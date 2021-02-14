class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    stored_location = stored_location_for(resource)
    if stored_location
      stored_location
    else current_user.questionnaire.nil?
      new_questionnaires_path
    end
  end
end
