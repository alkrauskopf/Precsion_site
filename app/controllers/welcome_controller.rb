class WelcomeController < ApplicationController

  def index
  #  load_team
  @welcomes = Offering.welcomes.active
  @testimonials = Offering.testimonials.active
  @partners = Offering.partners.active
  @users = User.core_team
  @carousel_images = current_mission.carousel_images
  end

end
