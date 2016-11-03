class UsersController < ApplicationController
  before_action :pm_offerings, except: []
  before_action :set_user, only: []
  before_action :banner_image, except: []

  def index
    if admin_authorized?
      @users = User.all
    else
      redirect_to root_path
    end
  end

  def login
    # GET action for the login page
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
        :first_name, :last_name, :email,
        :title, :picture, :is_contactee,
        :password, :password_confirmation,
        :user_class_id
    )
  end

end
