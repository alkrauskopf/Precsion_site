class Stat < ActiveRecord::Base

  belongs_to :offering

  def self.by_position
    order('position ASC')
  end

  def active?
    self.is_active
  end

  def self.active
    where('is_active = ?', true)
  end

end
