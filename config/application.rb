require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MRMS
  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_job.queue_adapter = :sidekiq

    config.autoload_paths += Dir[Rails.root.join('lib')]
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{*/}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'controllers/admin')]

    config.time_zone = "Pacific Time (US & Canada)"
    config.active_record.time_zone_aware_types = [:datetime, :time]

    # config.elastic_apm.service_name = 'MRMS APM'

  end
end
