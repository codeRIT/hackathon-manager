class MessageTemplate < ApplicationRecord
  class << self
    # Maximum amount of time to use the in-memory singleton before checking the database for updates.
    SINGLETON_MAX_AGE = 30.seconds.from_now

    # Retrieve the instance.
    # Use the one stored in memory if it is recent enough.
    def instance
      if Time.now > @singleton_expiration
        load_singleton
      end
      @singleton_instance
    end

    # Retrieve the instance from the database
    def uncached_instance
      first
    end

    # Load the current template into memory.
    # If one doesn't exist yet, import it.
    def load_singleton
      if none?
        replace_with_default
      end
      @singleton_expiration = SINGLETON_MAX_AGE
      @singleton_instance = uncached_instance
    end

    # Replace stored template with default HackathonManager template
    def replace_with_default
      html = File.read("db/message-template-default.html.mustache")
      MessageTemplate.destroy_all
      create!(html: html)
    end
  end

  load_singleton

  validates :html, presence: true
  after_save :refresh_singleton

  def customized?
    updated_at != created_at
  end

  private

  # Note that each Ruby process has its own memory space (web, sidekiq, console, etc),
  # and calling refresh_singleton only updates the current memory space.
  # It may take up to SINGLETON_MAX_AGE for other spaces to notice updates.
  def refresh_singleton
    MessageTemplate.load_singleton
  end
end
