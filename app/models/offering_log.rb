class OfferingLog < ActiveRecord::Base


  belongs_to :offering

  def self.current
    cp = Date.current.year.to_s + Date.current.month.to_s
    where('period = ?', cp).first rescue nil
  end

  def self.period_up
    order('period ASC')
  end

  def self.period_down
    order('period DESC')
  end

end
