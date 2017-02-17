class ReservationsController < ApplicationController
  before_action :admin_authorize, :set_reservation, only: [:edit, :update, :destroy]
  before_action :prep_offering, :precision_prep_admin?
  before_action :no_flash, except: [:index]
  before_action :banner_image, except: []

  def index
    @reservations = Reservation.all
    @reservation = Reservation.new
    @pending_events = Event.pending
  end

  def new
    set_event
    @captcha_pass = true
    @reservation = Reservation.new
  end

  def create
    set_event
    used_captcha
    @reservation = Reservation.new(reservation_params)
    @reservation.event_id = @event.id
    if @reservation.save && @captcha_pass
      @reservation.email_us!
      redirect_to prep_reservation_path, notice: "#{@reservation.last_name.upcase} Enrollment Request Status: #{@reservation.status.upcase}"
    else
      render :new
    end

  end

  def edit
    @event = @reservation.event
    @captcha_pass = true
  end

  def update
    @event = @reservation.event
    @captcha_pass = true
    if @reservation.update(reservation_params)
      flash[:notice] = "Updated #{@reservation.full_name} Reservation"
      redirect_to prep_reservation_path
    else
      render :edit
    end
  end

  def destroy
    if (!@reservation.nil? && @reservation.destroy)
      flash[:notice] = 'Reservation was successfully destroyed.'
    else
      flash[:error] = "#{@reservation.full_name} Enrollment Not Destroyed. Check that status is 'Removed'"
    end
    redirect_to prep_reservation_path
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_event
    @event = Event.find_by_id(params[:event_id])
  end

  def reservation_params
    if params[:reservation][:status].present? && !@reservation.status.nil?
      params[:reservation][:status] = (params[:reservation][:status] == '' ? @reservation.status : params[:reservation][:status].to_i)
    else
      params[:reservation][:status] = 0
    end
    params.require(:reservation).permit(:event_id, :first_name, :last_name, :email, :status, :notes)
  end

  def prep_offering
    @prep = Offering.prep_parent
  end

  def used_captcha
    @captcha = CaptchaImage.find_by_id(params[:reservation][:captcha_id]) rescue nil
    @captcha_guess = params[:captcha_guess]
    @captcha_pass = (!@captcha.nil? && @captcha_guess.upcase.include?(@captcha.name.upcase)) || @captcha.nil?
    @captcha_error = 'Picture Not Identified Correctly'
  end


end
