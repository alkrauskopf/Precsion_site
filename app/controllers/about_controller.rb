class AboutController < ApplicationController

  before_action :pm_offerings, except: []
  before_action :set_offering, only: [:pm_offering]


  def index

  end

  def our_team
    #  load_team
    @users = User.full_team
  end

  def pm_offering
    @offerings = @offering.nil? ? [] : @offering.children_by_position
    @povs = @offering.nil? ? [] : @offering.povs
    @header_image = @offering.nil? ? nil : @offering.header_image
    @images = @offering.nil? ? [] : @offering.non_header_image
    @stats = @offering.nil? ? [] : @offering.active_stats
  end

  def partnering
    @method = Offering.partnering_parent
    @methods = @method.nil? ? [] : @method.children_by_position
  end

  private

  def set_offering
    @offering = Offering.find(params[:id]) rescue nil
  end



end
