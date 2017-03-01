class PaymentController < ApplicationController

  before_action :admin_authorize, only: []
  before_action :precision_prep_admin?
  before_action :banner_image, except: []
  before_action :set_buyable

  def new
    @token = 'new'
  end

  def create
    token = StripeToken.new(**card_params)
    workflow = PurchasesCart.new(
      buyable: @buyable, stripe_token: token,
      payment_amount_cents: @buyable.price_cents
    )
    workflow.run
    #  check status ---  assume success for now
    @buyable.confirm!
    redirect_to payment_show_path(:buyable_id => @buyable.id, :buyable_type => @buyable.class.to_s)
  end

  def show
    @payments = @buyable.payments
  end

  private

  def set_buyable
    if params[:buyable_type] && params[:buyable_type] == 'Reservation'
      @buyable = Reservation.find_by_id(params[:buyable_id]) rescue nil
      if !@buyable.nil?
        @buyer = @buyable.full_name
        @item = @buyable.event.name
        @venue = @buyable.event.venue.name
        @start_date = @buyable.event.start_date
        @end_date = @buyable.event.end_date
        @price = @buyable.price
        @status = @buyable.status
      end
    else
      @buyable = nil
    end
    if @buyable.nil?
      flash[:error] = "Purchase Item Not Found"
      redirect_to root_path(:id => Offering.prep_parent.id)
    end
  end

  def card_params
    params.permit(:credit_card_number, :expiration_month,
                    :expiration_year, :cvc, :stripe_token).to_h.symbolize_keys
  end

end
