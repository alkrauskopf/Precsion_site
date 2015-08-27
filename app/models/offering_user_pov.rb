class OfferingUserPov < ActiveRecord::Base

  belongs_to  :user_pov
  belongs_to  :offering

end
