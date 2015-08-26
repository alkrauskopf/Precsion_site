class Admin::OfferingsController < ApplicationController

  before_action :admin_authorize

  def index
    @offerings = Offering.all
  end
end
