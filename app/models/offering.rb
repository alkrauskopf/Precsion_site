class Offering < ActiveRecord::Base
  acts_as_tree

  has_many :offering_user_povs, dependent: :destroy
  has_many :user_povs, through: :offering_user_povs
  has_many :offering_images, dependent: :destroy

  def self.arrange_by_position
    order('display_position ASC')
  end

  def available_povs
   UserPov.all - self.user_povs
  end

  def visible?
    self.is_visible
  end

  def add_remove_pov!(pov)
    if self.offering_user_povs.associations_with(pov.id).empty?
      self.offering_user_povs.create(user_pov_id: pov.id)
    else
      self.offering_user_povs.associations_with(pov.id).destroy_all
    end
  end
end
