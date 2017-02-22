class Payment < ActiveRecord::Base
  belongs_to :buyable, polymorphic: true

  enum payment_method: {check: 0, cc: 1}

  def self.checks
    where('payment_method = ?', 0)
  end

  def self.credit_cards
    where('payment_method = ?', 1)
  end

  def check?
    self.payment_method == 'check'
  end

  def credit_card?
    self.payment_method == 'cc'
  end

end
