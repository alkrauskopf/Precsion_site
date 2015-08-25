class AboutController < ApplicationController

  def index

  end

  def our_team
    #  load_team
    @users = User.full_team
  end
end
