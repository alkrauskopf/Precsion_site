class OfferingImage < ActiveRecord::Base

  has_attached_file :image, styles: {thumb: "60x60#"}

  belongs_to :offering

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def self.by_position
    order('display_position ASC')
  end

  def self.carousels
    where('is_carousel_img')
  end

  def carousel?
    self.is_carousel_img
  end

  def active?
    self.is_active
  end

  def self.active
    where('is_active = ?', true)
  end
end
