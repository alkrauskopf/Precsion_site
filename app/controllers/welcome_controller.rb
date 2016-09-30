class WelcomeController < ApplicationController

  before_action :pm_offerings, except: []

  def index
  #  load_team
    @testimonials = Offering.testimonials.active
    @partners = Offering.partners.active
    @users = User.core_team
    @carousel_images = current_mission.nil? ? []:current_mission.carousel_images
    @research_parent = Offering.researches.active.all_parents.first
    @grant_parent = Offering.grants.active.all_parents.first
    @offering_parent = Offering.offerings.active.all_parents.first
    @tool_parent = Offering.tools.active.all_parents.first
    @consultant_parent = Offering.consultants.active.all_parents.first
    @marque = Offering.marque_stream
  end

end
