# Dockerfile

FROM ruby:3.1.7-slim

ARG UID=1000
ARG GID=1000

# ユーザー作成
RUN groupadd -g $GID appgroup && useradd -m -u $UID -g appgroup appuser

WORKDIR /rails

# 必要なライブラリ
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs yarn libyaml-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# ▼▼▼ 以下の3行を追加 ▼▼▼
# /usr/local/bundle ディレクトリを作成し、所有権を appuser に渡す
# (docker-compose.yml の volume マウント先と合わせる)
RUN mkdir -p /usr/local/bundle && chown -R appuser:appgroup /usr/local/bundle

# appuser に切り替えて bundle install
USER appuser

COPY --chown=appuser:appgroup Gemfile Gemfile.lock ./

# ▼▼▼ 競合する設定 (`bundle config ...`) を削除し、シンプルに bundle install する ▼▼▼
RUN gem install bundler -v 2.6.2 && bundle install

COPY --chown=appuser:appgroup . .

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
