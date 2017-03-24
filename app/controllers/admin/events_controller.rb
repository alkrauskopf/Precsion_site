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
      redirect_to prep_event_path
    else
      venue_list
      render :edit
    end
  end

  def destroy
    if (!@event.nil? && @event.destroy)
      flash[:notice] = 'Event was successfully destroyed.'
    else
      flash[:error] = 'Event Not Destroyed'
    end
    redirect_to prep_event_path
  end

  def event_terms_index
    @event_terms = PayTerm.all
  end
  def event_terms_new
    @event_terms = PayTerm.all
  end
  def event_terms_create
    @event_terms = PayTerm.all
  end
  def event_terms_update
    @event_terms = PayTerm.all
  end
  def event_terms_edit
    @event_terms = PayTerm.all
  end
  def event_terms_destroy
    @event_terms = PayTerm.all
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params[:event][:start_date] = Date.strptime(params[:event][:start_date], "%m/%d/%Y") if params[:event][:start_date].present?
    params[:event][:end_date] = Date.strptime(params[:event][:end_date], "%m/%d/%Y") if params[:event][:end_date].present?
    params[:event][:price] = Money.new(params[:event][:price_cents]) if params[:event][:price_cents].present?
    if !@event.nil? && !@event.e_type.nil?
      params[:event][:e_type] = (params[:event][:e_type] == '' ? @event.e_type : params[:event][:e_type].to_i)
    else
      params[:event][:e_type] = (params[:event][:e_type] == '' ? 0 : params[:event][:e_type].to_i)
    end
    params.require(:event).permit(:venue_id, :start_date, :end_date, :capacity, :price,
                                  :location, :time, :is_active, :e_type, :message, :name, :contact_name, :contact_email)
  end

  def venue_list
    @venue_select = Venue.active.sort_by{|v| v.name}.map{|v| [v.name, v.id]}
  end
end
