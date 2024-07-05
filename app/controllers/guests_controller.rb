class GuestsController < ApplicationController
before_action :find_event
def show 
   @guests = Guest.where(event_id: @event.id)
end
  def new 
    @guest= @event.guests.build
  end
  def create
    @guest = @event.guests.create(guest_params)
    
        redirect_to event_path(@event)
  end


  private 
  def find_event 
    @event = Event.find(params[:event_id])
  end 
  def guest_params 
    params.require(:guest).permit(:name, :companions)
  end
end
