class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy event_detail]
  before_action :authenticate_user!, except: %i[ show]

  # GET /events or /events.json
  def index
    @events
    Event.all.each do |e|
      e.close_event
    end
    if params[:opt]
      case params[:opt]
        when 'closed'
          @events = current_user.events.closed.paginate(page: params[:page], per_page: 6).order("id DESC")
        when 'upcoming'
          @events = current_user.events.upcoming_events.paginate(page: params[:page], per_page: 6).order("id DESC")
       
          
      else 
          @events = "Sorry, no Events found it"
      end
        #render "index"
    else
      @events = current_user.events.paginate(page: params[:page], per_page: 6).order(" id DESC")
    
    end
    
    return @events
    render "index"
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = current_user.events.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    @event.close_event
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to root_path, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  #custom functions
  def event_detail

  end

  private
    def set_event
     event = Event.find_by(id: params[:id])
     if event 
          return @event = event 
      else 
          redirect_to error_path
     end

    end
    def event_params
      params.require(:event).permit(:name, :event_date, :address, :capacity, :message)
    end
end
