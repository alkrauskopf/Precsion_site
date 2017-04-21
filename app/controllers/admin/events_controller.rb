class Admin::EventsController < ApplicationController

  before_action :admin_authorize, :set_event, only: [:edit, :update, :destroy]
  before_action :banner_image, except: []
  before_action :set_pay_term, only: [:event_terms_edit, :event_terms_update, :event_terms_destroy]

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
    @pay_terms = PayTerm.all
  end
  def event_terms_new
    @pay_term = PayTerm.new
  end
  def event_terms_create
    @pay_term = PayTerm.new(pay_term_params)
    if @pay_term.save
      flash[:notice] = "Pay Terms Created"
    else
      flash[:error] = @pay_term.errors.full_messages
    end
    redirect_to event_terms_path
  end
  def event_terms_update
    if @pay_term.update(pay_term_params)
      flash[:notice] = 'Pay Terms Updated'
      redirect_to event_terms_path
    else
      render :event_terms_edit
    end
  end

  def event_terms_edit

  end
  def event_terms_destroy
    if (!@pay_term.nil? && @pay_term.destroy)
      flash[:notice] = 'Pay Term was successfully destroyed.'
    else
      flash[:error] = 'Pay Term Not Destroyed'
    end
    redirect_to event_terms_path
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
                                  :location, :time, :is_active, :e_type, :message, :name, :contact_name, :contact_email,
                                  :terms_for)
  end

  def venue_list
    @venue_select = Venue.active.sort_by{|v| v.name}.map{|v| [v.name, v.id]}
  end

  def set_pay_term
    @pay_term = PayTerm.find(params[:id]) rescue nil
  end

  def pay_term_params
    if !@pay_term.nil? && !@pay_term.e_type.nil?
      params[:pay_term][:e_type] = (params[:pay_term][:e_type] == '' ? @pay_term.e_type : params[:pay_term][:e_type].to_i)
    else
      params[:pay_term][:e_type] = (params[:pay_term][:e_type] == '' ? 0 : params[:pay_term][:e_type].to_i)
    end
    params.require(:pay_term).permit(:title, :terms, :e_type, :is_active)
  end
end
