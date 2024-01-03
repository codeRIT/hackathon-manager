require_relative 'boot'

require 'rails/all'

require "./lib/hackathon_manager"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HackathonManager
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = ENV["TIME_ZONE"].presence || "UTC"

    config.active_job.queue_adapter = :sidekiq

    config.to_prepare do
      # Only Applications list
      Doorkeeper::ApplicationsController.layout "manage/application"

      # Only Authorized Applications
      Doorkeeper::AuthorizedApplicationsController.layout "application"
    end

    # https://discuss.rubyonrails.org/t/cve-2022-32224-possible-rce-escalation-bug-with-serialized-columns-in-active-record/81017
    # config.active_record.yaml_column_permitted_classes = [Date, Time, ActiveSupport::TimeWithZone, ActiveSupport::TimeZone]

  end
end
