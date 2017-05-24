Gem.loaded_specs['hackathon_manager'].dependencies.each do |d|
 require d.name
end

module HackathonManager
  class Engine < ::Rails::Engine
    initializer "hackathon_manager.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        hackathon_manager/manage.css
        hackathon_manager/home.css
        hackathon_manager/vendor/*.js
        hackathon_manager/vendor/*.css
        hackathon_manager/mailer.css
        hackathon_manager/us.json
      )
    end
  end
end
