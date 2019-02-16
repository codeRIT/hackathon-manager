# RailsSettings Model
class HackathonConfig < RailsSettings::Base
  source HackathonManager::Engine.root.join("config/app.yml")

  # When config/app.yml has changed, you need change this prefix to v2, v3 ... to expires caches
  # cache_prefix { "v1" }
end
