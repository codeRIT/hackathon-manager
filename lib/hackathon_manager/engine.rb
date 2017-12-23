Gem.loaded_specs['hackathon_manager'].dependencies.each do |d|
  require d.name
end

module HackathonManager
  class Engine < ::Rails::Engine
    initializer "hackathon_manager.assets.precompile" do |app|
      app.config.assets.precompile += %w[
        hackathon_manager/manage.css
        hackathon_manager/core.css
        hackathon_manager/home.css
        hackathon_manager/vendor/*.js
        hackathon_manager/vendor/*.css
        hackathon_manager/mailer.css
      ]
    end

    # Watch hackathon.yml for changes & reload
    initializer "hackathon_manager.watch_hackathon_config", after: :load_config_initializers do |app|
      hackathon_config_reloader = app.config.file_watcher.new(['config/hackathon.yml']) do
        HackathonManager.reload_config(app)
      end

      app.reloaders << hackathon_config_reloader

      # Reload renderers in dev when files change
      app.config.to_prepare { hackathon_config_reloader.execute_if_updated }
    end

    # Initializer to combine this engines static assets with the static assets of the hosting site.
    initializer "static assets" do |app|
      app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
    end

    initializer 'hackathon_manager.factories', after: 'factory_bot.set_factory_paths' do
      FactoryBot.definition_file_paths << File.expand_path('../../../test/factories', __FILE__) if defined?(FactoryBot)
    end

    ActionController::Base.class_eval do
      # Tell Devise where to redirect the user once they sign in
      def after_sign_in_path_for(resource)
        stored_location = stored_location_for(resource)
        if stored_location
          stored_location
        elsif current_user.admin?
          manage_root_path
        elsif current_user.questionnaire.nil?
          new_questionnaires_path
        else
          @questionnaire = current_user.questionnaire
          @questionnaire.can_rsvp? ? rsvp_path : questionnaires_path
        end
      end
    end
  end
end
