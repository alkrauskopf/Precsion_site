class Content < ActiveRecord::Base

  belongs_to :offering

  validates_presence_of :content_url, :title

  def self.by_position
    order('position ASC')
  end

  def type
    self.content_type
  end

  def active?
    self.is_active
  end

  def exist?
    !self.content_url.nil? && !self.content_url.empty?
  end

  def self.active
    where('is_active = ?', true)
  end

  def url
    if self.offering && self.exist?
      '../../../assets/' + self.offering.content_directory + self.content_url
    else
      ''
    end
  end
end
