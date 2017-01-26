class OfferingTestimony < ActiveRecord::Base

  belongs_to  :offering
  belongs_to :testimony, :class_name => 'Offering', :foreign_key => "testimony_id"

  def self.for(offering, tst)
    where('offering_id = ? AND testimony_id = ?', offering.id, tst.id )
  end
end
