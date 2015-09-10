class Offering < ActiveRecord::Base

  acts_as_tree

  has_many :offering_user_povs, dependent: :destroy
  has_many :user_povs, through: :offering_user_povs
  has_many :offering_images, dependent: :destroy

  def self.arrange_by_position
    order('display_position ASC')
  end

  # both methods below are unnecessary and should be implemented with 'acts_as_tree' gem
  def self.find_parent(child)
    if child.parent_id.nil?
      'parent offering'
    else
      find(child.parent_id)
    end
  end

  def self.find_children
    Offering.all.select { |offering| offering.parent_id == self.id }
  end

  def visible?
    self.is_visible
  end
end
