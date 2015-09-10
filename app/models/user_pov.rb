class UserPov < ActiveRecord::Base

  belongs_to :user

  has_many :offering_user_povs, dependent: :destroy
  has_many :offerings, through: :offering_user_povs



end
