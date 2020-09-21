class UsersController < ApplicationController
  before_action :logged_in
  respond_to :json

  def logged_in
    authenticate_user!
  end

  def show
    respond_to do |format|
      format.json { render json: current_user }
    end
  end
end
