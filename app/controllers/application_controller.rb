class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :contact_log, :admin_authorized?


  def admin_authorize
    if !admin_authorized?
      redirect_to root_path
    end
  end

  def load_team
    @names = []
    @pics = []
    @titles = []
    @bios = []
    @user_classes = []
    @educations = []
    @passions = []
    @briefs = []

    @names[0] = 'Dr. Mary Lindimore'
    @pics[0] = 'people/lindimore.jpg'
    @titles[0] = 'Founder & Managing Partner'
    @briefs[0] = 'Former Principal, Colorado State Director: NCTL'
    @bios[0] = '<p>Dr. Mary Lindimore serves as the State Director of School and District Support in Colorado for Precision.
                Dr. Lindimore oversees all school and district contracts, provides supports to diagnostic review teams and
                improvement planning processes in schools. She has worked on the front lines of education reform as a senior director
                for a nationally recognized non-profit whose mission was education research and reform. </p>
                <p>Throughout her career Mary has also served as a teacher of science and social studies, an instructional coach,
                pioneering the role for one of the nation’s largest school districts and as a school administrator who worked in high-poverty schools.
                In addition, Mary spent more than a decade as an adjunct professor in the fields of teacher education, school leadership,
                and educational psychology. She has co-authored several publications including a widely heralded science text for middle
                school students and Standards in Action, a publication by the Colorado Department of Education.
                Mary has presented on the national level many times using creative strategies to provide clarity on reform efforts for educational leaders.
                She has advocated for, and initiated, constructive change reform efforts in Colorado, providing testimony for the
                Colorado Congressional committee on education about the need for reform.
                She has published, presented, and consulted nationally on STEM curriculum, problem-based learning,
                effective tools for the implementation of standards, how to integrate work place competencies in the classroom, and school leadership.'

    @user_classes[0] = 'core'
    @educations[0] = 'BA, University of Colorado, MBA University of Phoenix, PhD University of Denver'
    @passions[0] = 'STEM Curriculum, Standards Implementation, School Leadership'

    @names[1] = 'Dr. Carol Sorvig'
    @pics[1] = 'people/sorvig.jpg'
    @titles[1] = ''
    @briefs[1] = 'Former Principal. SPED specialist.'
    @bios[1] =''
    @user_classes[1] = 'core'
    @educations[1] = 'BA ....'
    @passions[1] = 'STEM Curriculum, Standards Implementation, School Leadership'

    @names[2] = 'Dr. Karen Taylor'
    @pics[2] = 'people/taylor.jpg'
    @titles[2] = ''
    @briefs[2] = "Former Principal, Alternative Education.  Teacher Effectiveness."
    @bios[2] = ''
    @user_classes[2] = 'core'
    @educations[2] = 'BA ....'
    @passions[2] = ''

    @names[3] = 'Ms. Jill Colby'
    @pics[3] = 'people/colby.jpg'
    @titles[3] = ''
    @briefs[3] = "Former Middle & High School Principal.  Scheduling"
    @bios[3] = ''
    @user_classes[3] = 'core'
    @educations[3] = 'BA ....'
    @passions[3] = ''

    @names[4] = 'Ms. Paula Redig'
    @pics[4] = 'people/redig.jpg'
    @titles[4] = ''
    @briefs[4] = "bio needed"
    @bios[4] = ''
    @user_classes[4] = 'core'
    @educations[4] = 'BA ....'
    @passions[4] = ''

    @names[5] = 'Ms. Lisa Pryor'
    @pics[5] = 'people/pryor.jpg'
    @titles[5] = ''
    @briefs[5] = "Former Assistant Commissioner of Education, Oklahoma. Managing Director:NCTL"
    @bios[5] = ''
    @user_classes[5] = 'consultant'
    @educations[5] = 'BA ....'
    @passions[5] = ''

    @names[6] = 'Ms. Patricia Stazko'
    @pics[6] = 'people/staszko.jpg'
    @titles[6] = ''
    @briefs[6] = "SPED Consultant"
    @bios[6] = ''
    @user_classes[6] = 'consultant'
    @educations[6] = 'BA ....'
    @passions[6] = ''

    @names[7] = 'Dana Frazee'
    @pics[7] = 'people/frazee.jpg'
    @titles[7] = ''
    @briefs[7] = "."
    @bios[7] =''
    @user_classes[7] = 'core'
    @educations[7] = 'BA ....'
    @passions[7] = ''

    @names[8] = 'Allen Krauskopf'
    @pics[8] = 'people/krauskopf.jpg'
    @titles[8] = 'Managing Partner'
    @briefs[8] = "Former Assc.Partner, PwC Consulting.   Transformation, Tech Strategy."
    @bios[8] = ''
    @user_classes[8] = 'core'
    @educations[8] = 'BS Mathematics, MBA, MS Management of Technology'
    @passions[8] = ''
  end

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

  def admin_authorized?
    Authorization.admin.user_authorizations.empty? || (logged_in? && current_user.admin?)
  end
end
