class Admin::EventsController < ApplicationController

  before_action :admin_authorize, :set_event, only: [:edit, :update, :destroy]
  before_action :banner_image, except: []

  def index
    @venues = Venue.active.select{|v| !v.events.empty?}
  end

  def new
    @event = Event.new
    venue_list
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event Created"
    else
      flash[:error] = @event.errors.full_messages
    end
    redirect_to prep_event_path
  end

  def edit
    venue_list
  end

  def update
    if @event.update(event_params)
      flash[:notice] = 'Updated Event'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to prep_event_path
  end

  def destroy
    if (!@event.nil? && @event.destroy)
      flash[:notice] = 'Event was successfully destroyed.'
    else
      flash[:error] = 'Event Not Destroyed'
    end
    redirect_to prep_event_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params[:event][:start_date] = Date.strptime(params[:event][:start_date], "%m/%d/%Y") if params[:event][:start_date].present?
    params[:event][:end_date] = Date.strptime(params[:event][:end_date], "%m/%d/%Y") if params[:event][:end_date].present?
    params.require(:event).permit(:venue_id, :start_date, :end_date, :capacity, :price,
                                  :location, :time, :is_active)
  end

  def venue_list
    @venue_select = Venue.active.sort_by{|v| v.name}.map{|v| [v.name, v.id]}
  end
end
