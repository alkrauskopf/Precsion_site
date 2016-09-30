class Admin::AdminsController < ApplicationController

  before_action :pm_offerings, except: []
  before_action :admin_authorize

  before_action :set_user, only: [:destroy, :roles]

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

end
