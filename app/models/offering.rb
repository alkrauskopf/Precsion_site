class Offering < ActiveRecord::Base

  has_many :offering_user_povs, dependent: :destroy
  has_many :user_povs, through: :offering_user_povs
  has_many :images, dependent: :destroy

  def self.arrange_by_position
    order('display_position ASC')
  end

end
