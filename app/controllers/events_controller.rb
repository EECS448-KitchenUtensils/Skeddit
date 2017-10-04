class EventsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]
  before_action :check_format
  before_action :check_possible_times, :only => [:new, :create, :edit, :update]

  # Create an instance var of all of the events for use in the events#index page
  # PRE: None
  # POST: None
  def index
    @events = Event.all
    @admin_events = @events.select{|event| event.owner == current_user}
    @other_events = @events.reject{|event| event.owner == current_user}
  end

  # Create an instance var of the event with the specified id for the events#show page
  # PRE: None
  # POST: None
  def show
    @event = Event.find(params[:id])
    @availabilities = @event.availabilities
  end

  # Create an instance var for a new event for the events#new pages
  # PRE: None
  # POST: An event object is created
  def new
    @event = Event.new
    @possible_times = Event::POSSIBLE_TIMES_CONST
  end

  # Define what to do when creating a new event
  # PRE: None
  # POST: A new event is created, or an error message is shown
  def create
    @event = Event.new(event_params)
    @event.owner = current_user
    (@event.start.to_i .. @event.end.to_i).step(30.minute) do |date|
      puts(Time.at(date))
      a = Availability.new(start: Time.at(date))
      a.event = @event
      a.users << current_user
      a.save
    end
    @event.save
  end

  # Define what to do when trying to update an event.
  # PRE: The event with the specific id exists
  # POST: Event is updated with new day, times, or name
  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to(event_path(@event))
    end
  end

  # Find and destroy an event. Redirect to events#index.
  # PRE: The event with the specific id exists
  # POST: The event is removed
  def destroy
    @event = Event.find(params[:id])
    @event.destroy if @event.owner == current_user
    redirect_to(events_path)
  end

  private

  # Define the permitted params for creating a new event
  # PRE: None
  # POST: None
  def event_params
    params.require(:event).permit(:name, :start, :end)
  end

  # Define a variable with the current hour format setting. If none is set, default to 12.
  # PRE: None
  # POST: None
  def check_format
    @hour_format = session[:hour_format] || 12
  end

  # PRE: None
  # POST: None
  def check_possible_times
    @possible_times = Event::POSSIBLE_TIMES_CONST
  end
end
