# Provides actions for /events and /events/:id
class EventsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  # Create an instance var of all of the events for use in the events#index page
  # PRE:: None
  # POST:: None
  def index
    @events = Event.all
    @admin_events = @events.select{|event| event.owner == current_user}
    @other_events = @events.reject{|event| event.owner == current_user}
    @tasks = Task.where(user_id: current_user&.id)
  end

  # Create an instance var of the event with the specified id for the events#show page
  # PRE:: None
  # POST:: Shows the event and sorts it's availability by dates.
  def show
    begin
      @event = Event.find(params[:id])
    rescue
      render template:"shared/404"
      return
    end
    @tasks = @event.tasks.all
    @availabilities = @event.availabilities
    @dates = []

    @availabilities.each do |a|

      if !(@dates.include?(a.start.to_date))
        @dates << a.start.to_date
      end
    end
  end

  # Create an instance var for a new event for the events#new pages
  # PRE:: None
  # POST:: An event object is created
  def new
    @event = Event.new
  end

  # Define what to do when creating a new event
  # PRE:: None
  # POST:: A new event is created, and availabilities added.
  def create

    @event = Event.new(event_params)
    @event.owner = current_user
    (@event.start.to_i .. (@event.end.to_i - 30.minute)).step(30.minute) do |date|
      a = Availability.new(start: Time.at(date))
      a.event = @event
      a.users << current_user
      a.save
    end

    if @event.save
      redirect_to(events_path)
    else
      render :new
    end
  end

  # Find and destroy an event. Redirect to events#index.
  # PRE:: The event with the specific id exists
  # POST:: The event is removed
  def destroy
    @event = Event.find(params[:id])
    @event.destroy if @event.owner == current_user
    redirect_to(events_path)
  end

  private

  # Define the permitted params for creating a new event
  # PRE:: None
  # POST:: None
  def event_params
    params.require(:event).permit(:name, :start, :end)
  end


end
