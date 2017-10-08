class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_format

  # Simply redirects back to home page. Required since refreshing after a failed validation will bring you to this index.
  def index
    redirect_to (events_path)
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

  # Removes a user from an availability
  # PRE: None
  # POST: User specified will be free of his duty.
  def leave
    @availability = Availability.find(params[:availability_id])
    @user = User.find(params[:user_id])
    @availability.users.delete(@user)
    redirect_to(event_path(@availability.event.id))
  end

  # Adds a user to an availability
  # PRE: None
  # POST: One more user will belong to an availability.
  def join
    @availability = Availability.find(params[:availability_id])
    @user = User.find(params[:user_id])
    @availability.users << @user
    redirect_to(event_path(@availability.event.id))
  end

  # Copies availabilities from one day to a new one.
  # PRE: Days is after last availability in an event
  # POST: New day will be created with identicly times from date specified.
  def copydays
    @event = Event.find(params[:event_id])
    d_arr = params["date_o"].split('-')
    date = DateTime.new(d_arr[0].to_i, d_arr[1].to_i, d_arr[2].to_i, 0, 0)
    #check for errors.
    if DateTime.new(params["date"]["year"].to_i, params["date"]["month"].to_i, params["date"]["day"].to_i, 0, 0) < @event.availabilities.last.start
      flash[:alert] = 'Day already exists.'
      redirect_to(event_path(params[:event_id]))
      return
    end
    @availabilities_to_copy = @event.availabilities.where('start BETWEEN ? AND ?', date.beginning_of_day, date.end_of_day).all
    @availabilities_to_copy.each do |a|
      @new_a = Availability.new
      @new_a.start = DateTime.new(params["date"]["year"].to_i, params["date"]["month"].to_i, params["date"]["day"].to_i, a.start.hour, a.start.min)
      @event.availabilities << @new_a
      @new_a.save
    end
    redirect_to(event_path(params[:event_id]))
  end

  # Make more availabilities.
  # PRE: The new start time is after the last availability time.
  # POST: New availabilities will be added to the event.
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
