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
      redirect_to event_path(availability_params[:event_id]), flash: {notice: "Availability not saved!"}
    end
  end

  def edit
    @availability = Availability.find(params[:id])
    @times_allowed = @availability.event.times_allowed.map(&:to_datetime)
  end

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
    event_id = @availability.event.id
    @availability.destroy
    redirect_to(event_path(event_id))
  end


  def show
    @availability = Availability.find(params[:id])
  end

  def leave
    @availability = Availability.find(params[:availability_id])
    @user = User.find(params[:user_id])
    @availability.users.delete(@user)
    redirect_to(event_path(@availability.event.id))
  end

  def join
    @availability = Availability.find(params[:availability_id])
    @user = User.find(params[:user_id])
    @availability.users << @user
    redirect_to(event_path(@availability.event.id))
  end

  def run
    puts 'hi'
  end

  def make
    @event = Event.find(params[:event_id])

    _start = DateTime.new(params['_start']['year'].to_i, params['_start']['month'].to_i, params['_start']['day'].to_i, params['_start']['hour'].to_i, params['_start']['minute'].to_i)
    _end = DateTime.new(params['_end']['year'].to_i, params['_end']['month'].to_i, params['_end']['day'].to_i, params['_end']['hour'].to_i, params['_end']['minute'].to_i)
    
    if _start >= _end
      flash[:alert] = "Times are not chronological"
      redirect_to(event_path(params[:event_id]))
      return
    end
    if _start <= params[:last_date]
      flash[:alert] = "You can only add availabilites after the last time."
      redirect_to(event_path(params[:event_id]))
      return
    end
    
    (_start.to_i .. (_end.to_i - 30.minute)).step(30.minute) do |date|
      a = Availability.new(start: Time.at(date))
      a.event = @event
      a.save
    end

    redirect_to(event_path(params[:event_id]))
  end

  private

  def availability_params
    params.require(:availability).permit(:event_id, :start_date, :end_date, :start_time, :end_time)
  end

  def availability_update_params
    params.require(:availability).permit(:user_id, :availability_id)
  end

  def check_format
    @hour_format = session[:hour_format] || 12
  end
end
