class UsersController < ApplicationController

  before_action :set_user, only: []

  def new
    if !authorized?
      @user = User.new
    else
      redirect_to root_path
    end
  end

  def index
    if authorized?
      @users = User.all
    else
      redirect_to root_path
    end
  end

  def login
    # GET action for the login page
  end

  def create
    if !authorized?
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = "#{@user.full_name} Created"
      else
        flash[:error] = @user.errors.full_messages
      end
    end
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
        :first_name, :last_name, :email,
        :title, :picture, :is_contactee, :password, :password_confirmation
    )
  end
end
