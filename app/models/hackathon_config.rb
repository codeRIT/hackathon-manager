# RailsSettings Model
class HackathonConfig < RailsSettings::Base
  cache_prefix { "v1" }

  scope :basics do
    field :hackathon_name, type: :string, default: "HackFoo"
    field :event_start_date, type: :string, default: Date.new(2000, 1, 1).to_s
    field :digital_hackathon, type: :boolean, default: false
  end

  scope :applying do
    field :accepting_questionnaires, type: :boolean, default: true
    field :last_day_to_apply, type: :string, default: Date.new(2000, 1, 1).to_s
    field :auto_late_waitlist, type: :boolean, default: false
    field :disabled_fields, default: ""
  end

  scope :styling do
    field :homepage_url, type: :string, default: ""
    field :default_page_title, type: :string, default: "HackFoo - Jan 1-2, 2017"
    field :logo_asset, type: :string, default: ""
    field :email_banner_asset, type: :string, default: ""
    field :favicon_asset, type: :string, default: ""
    field :custom_css, default: ""
  end

  scope :communications do
    field :email_from, type: :string, default: '"HackFoo" <hello@example.com>'
    field :disclaimer_message, default: ""
    field :thanks_for_applying_message, default: ""
    field :thanks_for_rsvp_message, default: ""
    field :questionnaires_closed_message, default: ""
    field :bus_captain_notes, default: ""
  end

end
