class WelcomeController < ApplicationController

  def index
  #  load_team

  @users = User.core_team

  end


end
