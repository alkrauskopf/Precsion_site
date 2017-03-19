class PurchasesCart

  attr_accessor :buyable, :stripe_token, :purchase_amount, :success, :payment

  def initialize(buyable:, stripe_token:, purchase_amount_cents:)
    @buyable = buyable
    @stripe_token = stripe_token
    @purchase_amount = Money.new(purchase_amount_cents)
    @success = false
    @continue = true
  end

  def run
    Payment.transaction do
#      create_payment
      pre_purchase
#      charge
      purchase if @continue
      post_purchase if @continue
      @success = @continue
    end
  rescue ActiveRecord::ActiveRecordError => e
    Rails.logger.error("ACTIVE RECORD ERROR IN TRANSACTION")
    Rails.logger.error(e)
  end

  def calculate_success
    @success = payment.succeeded?
  end


#  def charge
#    charge = StripeCharge.charge(token: stripe_token, payment: payment)
#    payment.update!(
#        status: charge.status, response_id: charge.id,
#        full_response: charge)
#  end

  def redirect_on_success_url
    nil
  end

  def create_payment
    self.payment = Payment.create!(payment_attributes)
  end

  def payment_attributes
    {buyable_id: buyable.id, buyable_type: buyable.class.to_s, price_cents: purchase_amount.cents,
     status: "created", reference: Payment.generate_reference,
     payment_method: "stripe", description: buyable.description}
  end


  def success?
    success
  end

end