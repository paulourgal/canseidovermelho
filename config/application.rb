require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Canseidovermelho
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.active_record.default_timezone = :local
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = "pt-BR"
    config.time_zone = 'Brasilia'
    config.encoding = "utf-8"
    I18n.config.enforce_available_locales = false

    config.assets.paths << Rails.root.join("vendor", "assets", "fonts")
    config.assets.precompile << /\.(?:svg|eot|otf|woff|ttf)$/
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.svg)

    config.assets.initialize_on_precompile = false

    # disabling Coffeescript
    config.generators.javascript_engine :js

    config.generators do |g|
      g.assets = false
      g.helper = false
    end
  end
end
