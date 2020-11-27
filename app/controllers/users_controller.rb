class UsersController < ApplicationController
  before_action :logged_in
  respond_to :json

  def logged_in
    authenticate_user!
  end

  def show
    render json: current_user
  end
end
