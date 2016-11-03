class OfferingsController < ApplicationController
  before_action :pm_offerings, except: []
  before_action :banner_image, except: []

  def index
    @offering = Offering.offerings.active.first
    @carousel_images = OfferingImage.carousels.active
  end
end
