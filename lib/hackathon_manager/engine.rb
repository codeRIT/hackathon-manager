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
