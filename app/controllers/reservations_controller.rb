class ReservationsController < ApplicationController
  before_action :admin_authorize, :set_reservation, only: [:edit, :update, :destroy]
  before_action :prep_offering, :precision_prep_admin?
  before_action :no_flash, except: [:index]
  before_action :banner_image, except: []

  def index
    get_e_type
    @reservations = Reservation.all
    @reservation = Reservation.new
    @pending_events = Event.pending(@e_type)
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
    @reservation.enrollment = enrollment_number(@event)
    @reservation.event_id = @event.id
    if @reservation.save && @captcha_pass
      @reservation.email_us!
      redirect_to prep_payment_path(:enrollment => @reservation.enrollment), notice: "#{@reservation.last_name.upcase} Enrollment Request Status: #{@reservation.status.upcase}"
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

  def validate
    set_enrollment
    go_pay = false
    if @reservation.nil? || @reservation.removed?
      flash[:error] = (@reservation.nil? || @reservation.removed?) ? "Your Sign-up Record Was Not Found" : nil
    elsif @reservation.event.expired? || !@reservation.event.active?
      flash[:error] = @reservation.event.name + "Is No Longer Available"
    elsif @reservation.confirmed?
      flash[:error] = "Your Sign-up Is Already Confirmed"
    else
      @reservation.validate!
      flash[:notice] = 'Your Sign-up Is ' + @reservation.status.upcase
      if !@reservation.event.free?
        go_pay = false
      end
    end
    if go_pay
      render :new_payment
    else
      redirect_to root_path(:id => Offering.prep_parent.id)
    end
  end


  def new_payment
    set_enrollment
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_event
    @event = Event.find_by_id(params[:event_id])
  end

  def set_enrollment
    @reservation = Reservation.find_by_enrollment(params[:enrollment]) rescue nil
  end

  def reservation_params
    if params[:reservation][:status].present? && !@reservation.status.nil?
      params[:reservation][:status] = (params[:reservation][:status] == '' ? @reservation.status : params[:reservation][:status].to_i)
    else
      params[:reservation][:status] = 0
    end
    params[:reservation][:phone] = phone_format(params[:reservation][:phone]) if params[:reservation][:phone].present?
    params.require(:reservation).permit(:event_id, :first_name, :last_name, :email, :status, :notes, :phone, :school)
  end

  def phone_format(string)
    string.gsub(/[- ]/, '').insert(3,'-').insert(7,'-')
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

  def enrollment_number(event)
    event.venue.abbrev + Date.today.year.to_s[2..3] + Reservation.last.id.to_s
  end

  def get_e_type
    @e_type = params[:e_type].present? ? params[:e_type] : nil
  end

end
