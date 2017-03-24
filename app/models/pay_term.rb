class PayTerm < ActiveRecord::Base
  enum e_type: {prep: 0, webinar: 1}

  validates_presence_of :e_type, :title, :terms


  def self.for(event)
    where('e_type = ? AND is_active', event.e_type).first
  end

end
