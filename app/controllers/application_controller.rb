class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :contact_log

  private

  def logged_in?
    !current_user.nil?
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

  def load_team
    @names = []
    @pics = []
    @titles = []
    @bios = []
    @names[0] = 'Dr. Mary Lindimore'
    @pics[0] = 'people/lindimore.jpg'
    @titles[0] = 'Founder & Managing Partner'
    @bios[0] = 'Former Principal, Colorado State Director: NCTL'
    @names[1] = 'Dr. Carol Sorvig'
    @pics[1] = 'people/sorvig.jpg'
    @titles[1] = ''
    @bios[1] = 'Former Principal. SPED specialist.'
    @names[2] = 'Dr. Karen Taylor'
    @pics[2] = 'people/taylor.jpg'
    @titles[2] = ''
    @bios[2] = "Former Principal, Alternative Education.  Teacher Effectiveness."
    @names[3] = 'Ms. Jill Colby'
    @pics[3] = 'people/colby.jpg'
    @titles[3] = ''
    @bios[3] = "Former Middle & High School Principal.  Scheduling"
    @names[4] = 'Ms. Paula Redig'
    @pics[4] = 'people/redig.jpg'
    @titles[4] = ''
    @bios[4] = "bio needed"
    @names[5] = 'Ms. Lisa Pryor'
    @pics[5] = 'people/pryor.jpg'
    @titles[5] = ''
    @bios[5] = "Former Assistant Commissioner of Education, Oklahoma. Managing Director:NCTL"
    @names[6] = 'Ms. Patricia Stazko'
    @pics[6] = 'people/staszko.jpg'
    @titles[6] = ''
    @bios[6] = "SPED Consultant"
    @names[7] = 'Dana Frazee'
    @pics[7] = 'people/frazee.jpg'
    @titles[7] = ''
    @bios[7] = "."
    @names[8] = 'Allen Krauskopf'
    @pics[8] = 'people/krauskopf.jpg'
    @titles[8] = 'Managing Partner'
    @bios[8] = "Former Assc.Partner, PwC Consulting.   Transformation, Tech Strategy."
  end

end
