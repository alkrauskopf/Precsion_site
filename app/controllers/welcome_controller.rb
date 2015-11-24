class WelcomeController < ApplicationController

  def index
  #  load_team
    @welcomes = Offering.welcomes.active
    @testimonials = Offering.testimonials.active
    @partners = Offering.partners.active
    @users = User.core_team
    @carousel_images = current_mission.carousel_images
    @research_parent = Offering.researches.active.all_parents.first
    @grant_parent = Offering.grants.active.all_parents.first
    @offering_parent = Offering.offerings.active.all_parents.first
    @tool_parent = Offering.tools.active.all_parents.first
  end

end
