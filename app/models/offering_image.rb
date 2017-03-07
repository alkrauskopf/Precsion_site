class OfferingImage < ActiveRecord::Base

  # Note:  Heroku does not support images stored in public/,   so image upload is not being implemented.
  # But here's how it is done below, anyway

 # has_attached_file :image, styles: {thumb: "60x60>", small_thumb: "50x50>", carousel: "1000x450>"}

  has_attached_file :image,
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename",
                    :styles => {thumb: "60x60>", small_thumb: "50x50>", carousel: "1000x450>"}

  belongs_to :offering

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def self.by_position
    order('display_position ASC')
  end

  def self.carousels
    where('is_carousel_img = ?', true)
  end

  def self.not_carousels
    where('is_carousel_img = ?', false)
  end

  def self.headers
    where('is_head = ?', true)
  end

  def self.not_headers
    where('is_head = ?', false)
  end

  def self.not_carousel_headers
    where('is_head = ? AND is_carousel_img = ?', false, false)
  end

  def carousel?
    self.is_carousel_img
  end

  def active?
    self.is_active
  end

  def exist?
    !self.url.nil? && !self.url.empty?
  end

  def self.active
    where('is_active = ?', true)
  end

  def pic
  #  self.offering ? self.offering.content_directory + (self.url.nil? ? '' : self.url) : ''
    self.image
  end

  def pic?
    self.image?
  end

  def header?
    self.display_position == 0
  end

  def head?
    self.is_head
  end

end
