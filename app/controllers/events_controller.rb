class EventsController < ApplicationController
  before_action :find_event, only: :show

  def index
    @events = Event.all
  end

  def show
  end

  private

  def find_event
    @event = Event.find_by_id(params[:id])
  end
end
