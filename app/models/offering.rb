class Offering < ActiveRecord::Base

has_many :offering_user_povs, dependent: :destroy
has_many :user_povs, through: :offering_user_povs

end
