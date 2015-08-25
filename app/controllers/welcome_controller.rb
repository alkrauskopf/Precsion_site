class WelcomeController < ApplicationController

  def index
  #  load_team

  @users = User.core_team
  @pov_users = User.with_povs
  end


end
