class AboutController < ApplicationController

  def index

  end

  def our_team
    #  load_team
    @users = User.full_team
  end

  def pm_methods
    @method = Offering.pm_parent
    @methods = @method.nil? ? [] : @method.children_by_position
  end
end
