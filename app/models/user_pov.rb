class UserPov < ActiveRecord::Base

  belongs_to :user

  has_many :offering_user_povs, dependent: :destroy
  has_many :offerings, through: :offering_user_povs


  def self.active
    where('is_active =?', true)
  end

  def active?
    self.is_active
  end
end
