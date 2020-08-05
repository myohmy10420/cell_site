require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module CellWeb
  class Application < Rails::Application
    config.load_defaults 5.2
    config.time_zone = "Taipei"
    config.i18n.default_locale = "zh-TW"
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
  end
end
