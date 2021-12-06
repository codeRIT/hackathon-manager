class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json

  def after_sign_in_path_for(resource)
    stored_location = stored_location_for(resource)
    if stored_location
      stored_location
    elsif current_user.questionnaire.nil?
      new_questionnaires_path
    else
      questionnaires_path
    end
  end
end
