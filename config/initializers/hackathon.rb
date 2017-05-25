Rails.application.configure do
  config.hackathon = config_for(:hackathon)

  # Applications without a specified config.time_zone will parse
  # this as a string instead of a DateTime
  if config.hackathon['last_day_to_apply'].is_a?(String)
    config.hackathon['last_day_to_apply'] = DateTime.parse(config.hackathon['last_day_to_apply'])
  end
end
