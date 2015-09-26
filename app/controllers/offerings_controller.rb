class OfferingsController < ApplicationController
  def index
    @offering = Offering.offerings.active.first
    @carousel_images = OfferingImage.carousels.active
  end
end
