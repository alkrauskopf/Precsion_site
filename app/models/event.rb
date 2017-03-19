class Event < ActiveRecord::Base

  belongs_to :venue
  has_many :reservations
  enum e_type: {prep: 0, webinar: 1}
  monetize :price_cents

  validates_format_of :contact_email, :with => /\A[\w._%+-]+@[\w.-]+\.[\w]{2,6}\z/, :message => 'invalid email format',
                      :allow_nil => false
  validates_presence_of :name, :contact_name


  def self.active
    where('is_active = ?', true)
  end

  def active?
    self.is_active
  end

  def self.pending(e_type)
    events = Event.where('start_date > ? AND is_active', Date.today).by_date
    if !e_type.nil?
      events = events.select{|e| e.e_type == e_type}
    end
    events
  end

  def self.by_date
    order('start_date ASC')
  end

  def open?
    self.capacity > self.reservations.confirmed.size
  end

  def reservable?
    self.active? && !self.expired? && !self.at_capacity?
  end

  def expired?
    self.start_date < Date.today
  end

  def free?
    self.price_cents == 0
  end

  def at_capacity?
    self.confirmed_reservations.size >= self.capacity
  end

  def confirmed_reservations
    self.reservations.select{|r| r.confirmed?}
  end

  def self.preps
    where('e_type = ?', 0)
  end

  def self.webinars
    where('e_type = ?', 1)
  end

  def prep?
    self.e_type == 'prep'
  end

  def webinar?
    self.e_type == 'webinar'
  end

  def type_name
    name = ''
    if self.webinar?
      name = 'Webinar'
    elsif self.prep?
      name = 'Tutoring'
    end
    name
  end

  def self.next_webinar
    Event.pending('webinar').first rescue nil
  end

  def valid_confirmed_reservations
    self.reservations.select{|r| r.validated? || r.confirmed?}
  end
end
