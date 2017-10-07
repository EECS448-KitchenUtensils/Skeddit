module EventScoped
    extend ActiveSupport::Concern
    def load_event
        @event = Event.find(params[:event_id])            
    end
    def owns_event
        unless @event.owner == current_user
            redirect_to events_path, :alert => "Must be event owner to modify!"
            return false
        end
        return true
    end
end