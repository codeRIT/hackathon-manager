class EventsController < ApplicationController
  respond_to :json

  def show
    render json: Event.all
  end
end
