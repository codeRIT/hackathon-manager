class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    stored_location = stored_location_for(resource)
    if stored_location
      stored_location
    elsif current_user.staff?
      manage_root_path
    elsif current_user.questionnaire.nil?
      new_questionnaires_path
    else
      questionnaires_path
    end
  end
end
