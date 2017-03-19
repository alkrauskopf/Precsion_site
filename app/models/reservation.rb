class Reservation < ActiveRecord::Base

  enum status: {pending: 0, validated: 1, confirmed: 2, removed: 3}
  monetize :price_cents

  belongs_to :event
  has_many :payments, :as => :buyable, :dependent => :destroy

  validates_presence_of :first_name, :last_name
  validates_format_of :email, :with => /\A[\w._%+-]+@[\w.-]+\.[\w]{2,6}\z/, :message => 'invalid email format',
                      :allow_nil => false
  validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad phone number format" }
  validates_uniqueness_of :enrollment
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

  def buyable?
    self.validated? && self.event.reservable? && !self.free?
  end

  def free?
    self.price_cents == 0
  end

  def email_us!
    self.update(was_notified: true)
    ReservationNotifier.notify_us(self).deliver_now
    ReservationNotifier.confirmation(self).deliver_now
  end

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def validate!
    if self.pending? || self.status.nil?
      self.update(:status=>'validated')
    end
  end

  def confirm!
    self.update(:status=>'confirmed')
  end

  def notification_list
   users = User.prep_emailees.map(&:email)
    if !self.event.contact_email.empty?
      users << self.event.contact_email
    end
    users.uniq.join(', ')
  end

  def description
    desc = ''
    if self.event
      desc += self.event.name[0..10] + ', '
      if self.event.venue
        desc += self.event.venue.name[0..6] + ', '
      end
      desc += self.event.start_date.to_s
    else
      desc = 'Event Not Identified'
    end
    desc
  end

  private

  def confirm_removed?
    self.removed?
  end
end
