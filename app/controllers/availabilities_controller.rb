class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_format

  # Simply redirects back to home page. Required since refreshing after a failed validation will bring you to this index.
  def index
    redirect_to (events_path)
  end

  # Redirects to a page for creation of an availability
  # PRE: None
  # POST: None
  def new
  end

  # Creates and stores a new availability, associated with a given event, in the database
  # PRE: None
  # POST: A new availability is stored in the database
  def create
    @availability = Availability.new(availability_params)
    @availability.user = current_user
    if @availability.save
      redirect_to (event_path(availability_params[:event_id]))
    else
      redirect_to (event_path(availability_params[:event_id]))
    end
  end

  # Redirects to a page to edit an availability
  # PRE: The availability exists
  # POST: None
  def edit
    @availability = Availability.find(params[:id])
    @times_allowed = @availability.event.times_allowed.map(&:to_datetime)
  end

  # Edits a given availability
  # PRE: The availability exists
  # POST: Changes are made to the availability in the database
  def update
    @availability = Availability.find(params[:id])
    @availability.user_id = availability_update_params[:user_id]
    @availability.save
    
  end

  # Destroys an availability
  # PRE: The availability exists
  # POST: The availability is removed from the database
  def destroy
    @availability = Availability.find(params[:id])
    @availability.destroy
    redirect_to(events_path)
  end

  # Redirects to a page showing the availability
  # PRE: None
  # POST: None
  def show
    @availability = Availability.find(params[:id])
  end

  private

  def availability_params
    params.require(:availability).permit(:event_id, :start_date, :end_date, :start_time, :end_time)
  end

  def availability_update_params
    params.require(:availability).permit(:user_id)
  end

  def check_format
    @hour_format = session[:hour_format] || 12
  end
end
