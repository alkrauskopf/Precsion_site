class Admin::AdminsController < ApplicationController

  before_action :pm_offerings, except: []
  before_action :admin_authorize
  before_action :set_user, only: [:destroy, :roles]
  before_action :banner_image, except: []
  before_action :set_captcha, only: [:destroy_captcha]

  def index
    @users = User.by_last_name
  end

  def roles
    authorization_ids = params[:user][:authorization_ids] rescue []
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
    @user.destroy if (!@user.nil? && @user != current_user)
    respond_to do |format|
      format.html { redirect_to admin_user_roles_path, notice: (@user != current_user ? 'User was successfully destroyed.': "Cannot Destroy One's Self") }
      format.json { head :no_content }
    end
  end

  def captchas
    @captchas = CaptchaImage.all
    @captcha = CaptchaImage.new
  end

  def create_captcha
    @captcha_image = CaptchaImage.new(captcha_params)

    respond_to do |format|
      if @captcha_image.save
        format.html { redirect_to admin_captchas_path, notice: "#{@captcha_image.name.upcase} has been created." }
        format.json { render :show, status: :ok, location: @captcha_image }
      else
        format.html { redirect_to admin_captchas_path, notice: "#{@captcha_image.errors}" }
        format.json { render json: @captcha_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_captcha
    @captcha_image.destroy
    respond_to do |format|
      format.html { redirect_to admin_captchas_path, notice: 'Captcha Image has been deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id]) rescue nil
  end

  def user_params
    params.require(:user).permit(
        :first_name, :last_name, :email,
        :phone, :password, :password_confirmation
    )
  end

  def set_captcha
    if params[:id]
      @captcha_image = CaptchaImage.find(params[:id])
    end
  end

  def captcha_params
    params.require(:captcha_image).permit(:name, :image)
  end
end
