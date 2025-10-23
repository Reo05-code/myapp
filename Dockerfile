FROM ruby:3.1.7-slim

WORKDIR /rails

# 必要なライブラリをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs yarn libyaml-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.6.2 && \
    bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY . .

CMD ["bash"]
