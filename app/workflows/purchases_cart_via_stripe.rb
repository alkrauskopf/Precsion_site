class PurchasesCartViaStripe < PurchasesCart

  attr_accessor :buyable, :stripe_token, :stripe_charge, :purchase_amount, :success, :payment

  def initialize(buyable:, stripe_token:, purchase_amount_cents:)
#    super(buyable: buyable, purchase_amount_cents: purchase_amount_cents)
    @buyable = buyable
    @stripe_token = stripe_token
    @purchase_amount = Money.new(purchase_amount_cents)
    @success = false
    @continue = true
  end

  def run
    Payment.transaction do
      pre_purchase
      purchase if @continue
      post_purchase if @continue
      @success = @continue
    end
  rescue ActiveRecord::ActiveRecordError => e
    Rails.logger.error("ACTIVE RECORD ERROR IN TRANSACTION")
    Rails.logger.error(e)
  end

  def pre_purchase_valid?
    @buyable.buyable? && @purchase_amount > 0
  end

  def pre_purchase
    if !pre_purchase_valid?
      @continue = false
      return
    end
    create_payment
    @continue = true
  end

  def purchase
    return unless @continue
   @stripe_charge = StripeCharge.new(token: stripe_token, payment: payment)
   @stripe_charge.charge
    payment.update!(@stripe_charge.payment_attributes)
    reverse_purchase if payment.failed?
  end

  def post_purchase
    if payment.failed?
    #  flash[:error] = 'Fail Fail Fail ' + payment.full_response.to_json
    else
    #  flash[:notice] = 'Good Good Good'  + payment.payment_method
    end
    return if !@continue
    @continue = calculate_success
  end

  def calculate_success
    payment.succeeded?
  end

  def create_payment
    self.payment = Payment.create!(payment_attributes)
  end

  def reverse_purchase

  end

  def redirect_on_success_url
    nil
  end

  def success?
    success
  end

  def payment_attributes
    {buyable_id: buyable.id, buyable_type: buyable.class.to_s, price_cents: purchase_amount.cents,
     status: "created", reference: Payment.generate_reference,
     payment_method: "stripe", description: buyable.description}
  end

end