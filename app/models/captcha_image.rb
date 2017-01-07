class CaptchaImage < ActiveRecord::Base

  # has_attached_file :image, styles: {thumb: "60x60>"}

  has_attached_file :image,
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename",
                    :styles => {thumb: "100x100>"}

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
