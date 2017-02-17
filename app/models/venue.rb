class Venue < ActiveRecord::Base

  has_many :events
  has_many :reservations, through: :events

  before_destroy :confirm_inactive?

  def self.by_name
    order('name ASC')
  end

  def active?
    self.is_active
  end

  def self.active
    where('is_active =?', true).by_name
  end

  private

  def confirm_inactive?
    !self.active?
  end
end
