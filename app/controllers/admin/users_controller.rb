class Admin::UsersController < ApplicationController

  before_action :pm_offerings, except: []
  before_action :admin_authorize
  before_action :set_user, only: [:roles, :destroy, :profile, :update]
  before_action :set_bio, only: [:update_bio]
  before_action :set_pov, only: [:destroy_pov]

  def index
    @users = User.by_position
  end

  def new
      @user = User.new
  end

  def create_bio
      @user_bio = UserBio.new(user_bio_params)
      if @user_bio.save
        flash[:notice] = "#{@user.full_name} Bio Created"
      else
        flash[:error] = @user.errors.full_messages
      end
      redirect_to admin_user_path(@user.id)
  end

  def update_bio
    if @user_bio.update(user_bio_params)
      flash[:notice] = 'Updated Bio'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to admin_user_path(@user.id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "#{@user.full_name} Created"
    else
      flash[:error] = @user.errors.full_messages
    end
    redirect_to root_path
  end

  def profile

    if @user.user_bio.nil?
      @user_bio = UserBio.new
    else
      @user_bio = @user.user_bio
    end
    @user_povs = @user.user_povs
    @new_pov = UserPov.new
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Updated User'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to admin_user_path(@user.id)
  end

  def roles
    if params[:user] && params[:user][:authorization_ids]
      authorization_ids = params[:user][:authorization_ids]
    else
      authorization_ids = []
    end
    @user.authorizations.destroy_all
    authorization_ids.each do |auth_id|
      @user.authorize!(auth_id)
    end
    respond_to do |format|
      format.html { redirect_to admin_user_roles_path}
      format.json { head :no_content }
    end
  end

  def destroy
    if (!@user.nil? && @user != current_user)
      @user.destroy
      flash[:notice] = 'User was successfully destroyed.'
    else
      flash[:error] = (logged_in? ? current_user.id.to_s : 'You Must Be Logged In')
    end
      respond_to do |format|
      format.html { redirect_to admin_user_roles_path }
      format.json { head :no_content }
    end
  end

  def create_pov
    @user_pov = UserPov.new(user_pov_params)
    if @user_pov.save
      flash[:notice] = "#{@user.full_name} POV Created"
    else
      flash[:error] = @user.errors.full_messages
    end
    redirect_to admin_user_path(@user.id)
  end

  def destroy_pov

    if @user_pov.destroy
      flash[:notice] = 'POV was successfully destroyed.'
    else
      flash[:error] = (logged_in? ? current_user.id.to_s : 'You Must Be Logged In')
    end
    respond_to do |format|
      format.html { redirect_to admin_user_path(@user.id)}
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
        :first_name, :last_name, :email,
        :title, :picture, :contactee, :display_position,
        :password, :password_confirmation,
        :user_class_id, :prefix, :is_emailee, :is_active
    )
  end

  def set_bio
    @user_bio = UserBio.find(params[:id])
  end

  def user_bio_params
    @user = User.find(params[:user_bio][:user_id])
    params.require(:user_bio).permit(
        :history, :user_id, :education,
        :brief, :passion
    )
  end

  def set_pov
    @user_pov = UserPov.find(params[:id])
    @user = @user_pov.user
  end

  def user_pov_params
    @user = User.find(params[:user_pov][:user_id])
    params.require(:user_pov).permit(
        :user_id, :name, :url
    )
  end
end
