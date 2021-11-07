class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user
  def mlh
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      render json: request.env["omniauth.auth"]
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      session["devise.provider_data"] = request.env["omniauth.auth"]
    else
      head :unauthorized
    end
  end

  def failure
    head :unauthorized
  end
end
