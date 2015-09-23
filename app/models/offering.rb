class Offering < ActiveRecord::Base
  acts_as_tree
  # trivial change
  has_many :offering_user_povs, dependent: :destroy
  has_many :user_povs, through: :offering_user_povs
  has_many :offering_images, dependent: :destroy

  validates_presence_of :offering_type

  def self.arrange_by_position
    order('display_position ASC')
  end

  def self.by_type
    order('offering_type ASC')
  end

  def available_povs
   UserPov.all - self.user_povs
  end

  def visible?
    self.is_visible
  end

  def self.active
    where('is_visible == ?', true)
  end

  def add_remove_pov!(pov)
    if self.offering_user_povs.associations_with(pov.id).empty?
      self.offering_user_povs.create(user_pov_id: pov.id)
    else
      self.offering_user_povs.associations_with(pov.id).destroy_all
    end
  end

  def offering?
    self.offering_type == 'O'
  end

  def tool?
    self.offering_type == 'T'
  end

  def welcome?
    self.offering_type == 'W'
  end

  def self.offerings
    where('offering_type == ?').order('display_position ASC')
  end

  def self.tools
    where('offering_type == ?', 'T').order('display_position ASC')
  end

  def self.welcomes
    where('offering_type == ?','W').order('display_position ASC')
  end

  def type_name
    name = 'Unknown Type'
    if self.offering_type == 'O'
      name = 'Offering'
    elsif self.offering_type == 'W'
      name = 'Welcome'
    elsif self.offering_type == 'T'
      name = 'Tool'
    end
    name
  end
end
