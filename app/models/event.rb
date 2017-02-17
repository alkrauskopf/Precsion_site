class Event < ActiveRecord::Base

  belongs_to :venue
  has_many :reservations

  monetize :price_cents


  def self.active
    where('is_active = ?', true)
  end

  def active?
    self.is_active
  end

  def self.pending
    where('start_date > ? AND is_active', Date.today).by_date
  end

  def self.by_date
    order('start_date ASC')
  end

  def open?
    self.capacity > self.reservations.confirmed.size
  end

end
