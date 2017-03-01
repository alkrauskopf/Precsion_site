class PurchasesCart

  attr_accessor :buyable, :stripe_token, :purchase_amount, :success, :payment

  def initialize(buyable:, stripe_token:, payment_amount_cents:)
    @buyable = buyable
    @stripe_token = stripe_token
    @purchase_amount = Money.new(payment_amount_cents)
    @success = false
  end

#  def tickets
#    @tickets ||= @user.tickets_in_cart
#  end

  def run
    Payment.transaction do
  #    purchase_tickets
      create_payment
      charge
      @success = payment.succeeded?
    end
  end

#  def purchase_tickets
 #   tickets.each(&:purchased!)
#  end

  def create_payment
    self.payment = Payment.create!(payment_attributes)
  end

  def payment_attributes
    {buyable_id: buyable.id, buyable_type: buyable.class.to_s, price_cents: purchase_amount.cents,
    status: "created", reference: Payment.generate_reference,
    payment_method: "stripe", description: buyable.description}
  end

  def charge
    charge = StripeCharge.charge(token: stripe_token, payment: payment)
    payment.update!(
        status: charge.status, response_id: charge.id,
        full_response: charge)
  end

end