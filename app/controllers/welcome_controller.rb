class WelcomeController < ApplicationController

  before_action :pm_offerings, except: []
  before_action :banner_image, except: []

  def index
    get_offering
    get_welcome_info
  end


  private
  def get_offering
    @offering = Offering.find(params[:id]) rescue nil
  end

  def get_welcome_info
    @testimonials = Offering.testimonials.active
    @partners = Offering.partners.active
    @users = User.core_team
    @carousel_images = current_mission.nil? ? []:current_mission.carousel_images
    @research_parent = Offering.researches.active.all_parents.first
    @grant_parent = Offering.grants.active.all_parents.first
    @offering_parent = Offering.offerings.active.all_parents.first
    @tool_parent = Offering.tools.active.all_parents.first
    @consultant_parent = Offering.consultants.active.all_parents.first
    @m_size = Offering.marques.active.not_expired.size
    @offering_list = Offering.welcome_offerings
    if @offering.nil?
      @offering = Offering.offerings.active.all_parents.first
    end
  end
end
