require_relative 'boot'

require "active_model/railtie" 
require "active_job/railtie"
require "action_controller/railtie" 
require "action_view/railtie" 
require "sprockets/railtie" 
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module LinkShortener
  class Application < Rails::Application
    config.load_defaults 5.2
    config.active_job.queue_adapter = :sidekiq
  end
end
