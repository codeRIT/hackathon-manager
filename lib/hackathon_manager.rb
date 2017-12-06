require "hackathon_manager/engine"

module HackathonManager
  def self.reload_config(app)
    hackathon = app.config_for(:hackathon)

    # Applications without a specified config.time_zone will parse
    # this as a string instead of a DateTime
    if hackathon['last_day_to_apply'].is_a?(String)
      hackathon['last_day_to_apply'] = DateTime.parse(hackathon['last_day_to_apply'])
    end

    app.config.hackathon = hackathon
  end
end
