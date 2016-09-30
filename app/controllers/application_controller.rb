class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :contact_log, :admin_authorized?,
                :current_mission, :escent_main_pages, :initial_setup?, :community_web_pages


  def admin_authorize
    if !admin_authorized?
      redirect_to root_path
    end
  end

  def pm_offerings
    @pm_offerings = Offering.pm.active
  end

  private

  def initial_setup?
    User.all.empty?
  end

  def logged_in?
    !current_user.nil? || initial_setup?
  end

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  rescue ActiveRecord::RecordNotFound
    session.delete(:id)
    nil
  end

  def contact_log
    ContactLog.new
  end

  def admin_authorized?
    Authorization.admin.user_authorizations.empty? || (logged_in? && current_user.admin?) || initial_setup?
  end

  def current_mission
    Offering.missions.active.first rescue nil
  end

  def escent_main_pages
    Escent.active.main_pages
  end

  def community_web_pages
    Escent.active.web_pages
  end

end
