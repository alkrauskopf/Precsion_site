class AboutController < ApplicationController

  def index
  #  load_team
    @users = User.core_team + User.consultants
  end
end
