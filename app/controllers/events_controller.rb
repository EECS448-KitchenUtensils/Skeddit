class EventsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]
  before_action :check_format

  # Create an instance var of all of the events for use in the events#index page
  def index
    @events = Event.all
    @admin_events = @events.select{|event| event.owner == current_user}
    @other_events = @events.reject{|event| event.owner == current_user}
  end

  # Create an instance var of the event with the specified id for the events#show page
  def show
    @event = Event.find(params[:id])
  end

  # Create an instance var for a new event for the events#new pages
  def new
    @event = Event.new
    @event.user_id = current_user.id
    @possible_times = Event::POSSIBLE_TIMES_CONST
  end

  # Define what to do when creating a new event
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to(events_path)
    else
      @possible_times = Event::POSSIBLE_TIMES_CONST
      render :new
    end
  end

  # Find event object to update and store possible_times in a var.
  def edit
    @event = Event.find(params[:id])
    @possible_times = Event::POSSIBLE_TIMES_CONST
  end

  # Define what to do when trying to update an event.
  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to(events_path)
    else
      @possible_times = Event::POSSIBLE_TIMES_CONST
      render :edit
    end
  end

  # Find and destroy an event. Redirect to events#index.
  def destroy
    @event = Event.find(params[:id])
    @event.destroy if @event.owner == current_user
    redirect_to(events_path)
  end

  private

  # Define the permitted params for creating a new event
  def event_params
    params.require(:event).permit(:name,:date,:user_id,:times_allowed => [])
  end

  # Define a variable with the current hour format setting. If none is set, default to 12.
  def check_format
    @hour_format = session[:hour_format] || 12
  end
end
