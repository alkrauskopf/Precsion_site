class WelcomeController < ApplicationController

  def index
  #  load_team
#  @welcomes = Offering.welcomes.active
    @welcomes = []
  @users = User.core_team
  @pov_users = User.with_povs
  end


end
