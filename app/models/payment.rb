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
end
