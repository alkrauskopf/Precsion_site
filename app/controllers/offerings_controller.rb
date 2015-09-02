class OfferingsController < ApplicationController
  def index
    @offerings = Offering.arrange_by_position
  end
end
