class OfferingUserPov < ActiveRecord::Base

  belongs_to  :user_pov
  belongs_to  :offering

  def self.associations_with(pov_id)
    where(user_pov_id: pov_id)
  end
end
