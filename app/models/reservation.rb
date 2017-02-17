class Reservation < ActiveRecord::Base

  enum status: {pending: 0, validated: 1, confirmed: 2, removed: 3}

  belongs_to :event

  validates_presence_of :first_name, :last_name
  validates_format_of :email, :with => /\A[\w._%+-]+@[\w.-]+\.[\w]{2,6}\z/, :message => 'invalid email format',
                      :allow_nil => false

  before_destroy :confirm_removed?

  def self.pendings
    where('status = ?', 0)
  end

  def self.valids
    where('status = ?', 1)
  end

  def self.confirms
    where('status = ?', 2)
  end

  def self.removes
    where('status = ?', 4)
  end

  def pending?
    self.status == 'pending'
  end

  def validated?
    self.status == 'validated'
  end

  def confirmed?
    self.status == 'confirmed'
  end

  def removed?
    self.status == 'removed'
  end

  def email_us!
    self.update(was_notified: true)
    ReservationNotifier.notify_us(self).deliver_now
    ReservationNotifier.confirmation(self).deliver_now
  end

  def full_name
    self.first_name + ' ' + self.last_name
  end

  private

  def confirm_removed?
    self.removed?
  end
end
