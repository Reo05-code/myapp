require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application

    config.load_defaults 7.1

    config.generators do |g|
      g.assets false          # CSS, JavaScriptファイルは生成しない
      g.test_framework false  # testファイルは生成しない
    end

    config.autoload_lib(ignore: %w(assets tasks))


  end
end
