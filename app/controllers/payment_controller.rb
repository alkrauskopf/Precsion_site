class PaymentController < ApplicationController

  before_action :admin_authorize, only: []
  before_action :precision_prep_admin?
  before_action :banner_image, except: []
  before_action :set_buyable, except: [:show]
  before_action :set_payment, only: [:show]


  def new
    buyable_instance_variables
  end

  def create
    token = StripeToken.new(**card_params)
    workflow = PurchasesCartViaStripe.new(
      buyable: @buyable,
      stripe_token: token,
      purchase_amount_cents: @buyable.price_cents
    )
    workflow.run
    payment_id = workflow.payment ? workflow.payment.id : nil
    charged_amount = workflow.payment ? (JSON.parse(workflow.payment.full_response)['amount'].to_i) : 0
    charged_string = Money.us_dollar(charged_amount).format(:with_currency => false)
    fee_string =  Money.us_dollar(@buyable.price_cents).format(:with_currency => false)
    cc_message = (workflow.payment && !JSON.parse(workflow.payment.full_response)['message'].nil?) ? (', ' + JSON.parse(workflow.payment.full_response)['message']) : ''
    status = workflow.payment ? workflow.payment.status.upcase : 'nil'
    if workflow.success
      @buyable.confirm!
      if workflow.payment
        matched_amount = @buyable.price_cents == charged_amount
        flash[:notice] = matched_amount ? ('Status: ' + status + ',  Charged Amount: ' + charged_string + cc_message) :
            ('Status: ' + status + ',  Charged Amount: ' + charged_string + ', Does Not Match Fee: ' + fee_string + cc_message)
        workflow.payment.email_payment_confirm!
      else
        flash[:error] = "Your Payment Was Successful, However We See No Immediate Record Of It.   Please Contact Us"
        @buyable.email_payment_problem!
      end
        redirect_to payment_show_path(:buyable_id => @buyable.id, :buyable_type => @buyable.class.to_s, :payment_id => payment_id)
    else
      flash[:error] = workflow.payment ? ('Status: ' + status + ',  Charged Amount: ' + charged_string +  cc_message) : "No Workflow Payment Recorded"
      redirect_to payment_new_path(:buyable_id => @buyable.id, :buyable_type => @buyable.class.to_s)
    end
  end

  def show
    @buyable = @payment.buyable
    if !@buyable.nil?
      buyable_instance_variables
    end
  end

  private

  def set_buyable
    if params[:buyable_type] && params[:buyable_type] == 'Reservation'
      @buyable = Reservation.find_by_id(params[:buyable_id]) rescue nil
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

  def set_payment
    @payment = Payment.find_by_id(params[:payment_id])
  end

  def buyable_instance_variables
    @buyer = @buyable.full_name
    @item = @buyable.event.name
    @time_frame = @buyable.event.time
    @venue = @buyable.event.venue.name
    @start_date = @buyable.event.start_date
    @end_date = @buyable.event.end_date
    @price = @buyable.price
    @status = @buyable.status
    @payments = @buyable.payments
    @pay_term = @buyable.pay_term
  end
end
