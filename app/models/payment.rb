class Payment < ActiveRecord::Base
  include HasReference

  belongs_to :buyable, polymorphic: true

  monetize :price_cents

  enum status: {created: 0, succeeded: 1, pending: 2, failed: 3}

  def self.stripes
    where('payment_method = ?', 'stripe')
  end

  def stripe?
    self.payment_method == 'stripe'
  end

  def total_cost
    self.buyable.price
  end

  def amount
    cents = JSON.parse(self.full_response)['amount'] rescue nil
    amount = Money.us_dollar(cents.nil? ? 0 : cents).format(:with_currency => false)
  end

  def ok_to_email?
    self.buyable && self.buyable.event && self.buyable.event.venue
  end

  def email_payment_confirm!
    PaymentNotifier.pay_confirm_user(self).deliver_now if self.ok_to_email?
    if self.ok_to_email?
      PaymentNotifier.pay_confirm_prec(self).deliver_now
    else
      PaymentNotifier.pay_confirm_prec_but(self).deliver_now
    end
  end
end
