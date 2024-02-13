require_relative "boot"

require "rails/all"

require "./lib/hackathon_manager"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HackathonManager
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

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
    config.active_record.yaml_column_permitted_classes = [Date, Time, ActiveSupport::TimeWithZone, ActiveSupport::TimeZone]
    config.active_support.disable_to_s_conversion = true
    config.active_support.cache_format_version = 7.1
    config.add_autoload_paths_to_load_path = false
  end
end
