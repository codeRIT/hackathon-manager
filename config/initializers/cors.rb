Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*/events.json', headers: :any, methods: [:get] # Workaround for now
  end
end
