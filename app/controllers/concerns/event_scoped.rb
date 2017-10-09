# ActiveSupport::Concern for controllers that are scoped to a single Event
module EventScoped
    extend ActiveSupport::Concern
    # Loads an Event instance into an instance variable @event
    # PRE:: The params hash contains an :event_id key
    # POST:: An Event instance is loaded
    def load_event
        @event = Event.find(params[:event_id])            
    end
    # Filters requests based on whether or not the current user owns the requested event
    # PRE:: A user is logged in and an Event has been loaded into this instance
    # POST:: The request is passed along if the user owns this Event, else rejected with a message
    def owns_event
        unless @event.owner == current_user
            redirect_to events_path, :alert => "Must be event owner to modify!"
            return false
        end
        return true
    end
end