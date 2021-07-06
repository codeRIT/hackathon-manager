class UsersController < ApplicationController
  before_action :logged_in
  respond_to :json

  def logged_in
    authenticate_user!
  end

  def show
    @user = current_user
  end
end
