class Offering < ActiveRecord::Base
  acts_as_tree

  has_many :offering_user_povs, dependent: :destroy
  has_many :user_povs, through: :offering_user_povs
  has_many :offering_images, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :stats, dependent: :destroy
  has_many :offering_logs, dependent: :destroy

  validates_presence_of :offering_type


  def self.all_parents
    where('parent_id IS NULL')
  end

  def ancestor
    anc = self
    until anc.parent_id.nil? do
      anc = anc.parent
    end
    anc
  end

  def all_children_by_position
    self.children.arrange_by_position
  end

  # 1st generation only
  def children_by_position
    self.children.where('parent_id = ?', self.id).order('display_position ASC')
  end

  def parent?
    self.parent_id.nil?
  end

  def images
    self.active_images
  end

  def header_image
    self.header_images.empty? ? nil : self.header_images.first
  end

  def non_header_image
    if !self.images.empty?
      self.images.select{ |i| !i.header?}
    else
      []
    end
  end

  def header_images
    if !self.images.empty?
      self.images.select{ |i| i.header?}
    else
      []
    end
  end

  def active_contents
    self.contents.active.by_position
  end

  def carousel_images
    self.offering_images.carousels.active.by_position
  end

  def active_images
    self.offering_images.active.by_position
  end

  def active_stats
    self.stats.active.by_position
  end

  def self.arrange_by_position
    order('display_position ASC')
  end

  def self.arrange_by_name
    order('name ASC')
  end

  def self.by_type
    order('offering_type ASC')
  end

  def povs
    self.user_povs
  end

  def available_povs
   UserPov.all - self.user_povs
  end

  def expired?
    !self.expire_date.nil? && self.expire_date < Date.today
  end

  def days_til_expire
    self.expire_date.nil? ? (10000): (self.expire_date - Date.today).to_i
  end

  def visible?
    self.is_visible
  end

  def self.active
    where('is_visible =?', true)
  end

  def self.expired
    where('expire_date <= ?', Date.today)
  end

  def self.not_expired
    where('expire_date > ?', Date.today)
  end

  def add_remove_pov!(pov)
    if self.offering_user_povs.associations_with(pov.id).empty?
      self.offering_user_povs.create(user_pov_id: pov.id)
    else
      self.offering_user_povs.associations_with(pov.id).destroy_all
    end
  end

  def offering?
    self.offering_type == 'O'
  end
  def services?
    self.offering?
  end

  def consultant?
    self.offering_type == 'C'
  end

  def tool?
    self.offering_type == 'E'
  end

  def welcome?
    self.offering_type == 'W'
  end

  def testimonial?
    self.offering_type == 'T'
  end

  def partner?
    self.offering_type == 'P'
  end

  def partnering?
    self.offering_type == 'A'
  end

  def mission?
    self.offering_type == 'M'
  end

  def research?
    self.offering_type == 'R'
  end

  def grant?
    self.offering_type == 'G'
  end

  def pm_method?
    self.offering_type == 'I'
  end

  def career?
    self.offering_type == 'Z'
  end

  def prep?
    self.offering_type == 'PP'
  end

  def self.welcome_offerings
    off = []
    off << Offering.testimonials.active.all_parents.first
    off << Offering.partners.active.all_parents.first
    off << Offering.offerings.active.all_parents.first
    off << Offering.grants.active.all_parents.first
    off << Offering.researches.active.all_parents.first
    off << Offering.tools.active.all_parents.first
    off << Offering.consultants.active.all_parents.first
    off << Offering.careers.active.all_parents.first
    off << Offering.preps.active.all_parents.first
    o_list = off.compact

  end
  def self.offerings
    where('offering_type = ?', 'O').order('display_position ASC')
  end

  def self.consultants
    where('offering_type = ?', 'C').order('display_position ASC')
  end

  def self.tools
    where('offering_type = ?', 'E').order('display_position ASC')
  end

  def self.welcomes
    where('offering_type = ?','W').order('display_position ASC')
  end

  def self.testimonials
    where('offering_type = ?','T').order('display_position ASC')
  end

  def self.partners
    where('offering_type = ?','P').order('display_position ASC')
  end

  def self.partnerings
    where('offering_type = ?','A').order('display_position ASC')
  end

  def self.partnering_parent
    Offering.all_parents.where('offering_type= ?', 'A').first
  end

  def self.missions
    where('offering_type = ?','M').order('display_position ASC')
  end

  def self.researches
    where('offering_type = ?','R').order('display_position ASC')
  end

  def self.grants
    where('offering_type = ?','G').order('display_position ASC')
  end

  def self.careers
    where('offering_type = ?','Z').order('display_position ASC')
  end

  def self.marque_stream
    self.marques.active.not_expired.empty? ? '' : (' . . . . ' + (self.marques.active.not_expired.map{|m| m.brief}.join(' . . . . ')).squeeze(" "))
  end

  def self.marques
    where('offering_type = ?','Q').order('display_position ASC')
  end

  def self.pm
    where('offering_type = ?','I').order('display_position ASC')
  end

  def self.preps
    where('offering_type = ?','PP').order('display_position ASC')
  end

  def self.pm_parent
    Offering.all_parents.where('offering_type= ?', 'I').first
  end

  def self.prep_parent
    Offering.all_parents.where('offering_type= ?', 'PP').first
  end

  def vision
    current_mission.children_by_position.active.where('offering_type = ?', self.offering_type).first.brief rescue ''
  end

  def vision_label
    current_mission.children_by_position.active.where('offering_type = ?', self.offering_type).first.name rescue ''
  end

  def type_name
    name = 'Unknown Type'
    if self.offering_type == 'O'
      name = 'Offering'
    elsif self.offering_type == 'W'
      name = 'Welcome'
    elsif self.offering_type == 'E'
      name = 'Tool'
    elsif self.offering_type == 'T'
      name = 'Testimonial'
    elsif self.offering_type == 'P'
      name = 'Partner'
    elsif self.offering_type == 'A'
      name = 'Partnering'
    elsif self.offering_type == 'M'
      name = 'Mission'
    elsif self.offering_type == 'R'
      name = 'Research'
    elsif self.offering_type == 'G'
      name = 'Grant'
    elsif self.offering_type == 'Q'
      name = 'Marque'
    elsif self.offering_type == 'C'
      name = 'Consultant'
    elsif self.offering_type == 'I'
      name = 'Performance Monitoring'
    elsif self.offering_type == 'Z'
      name = 'Career'
    elsif self.offering_type == 'PP'
      name = 'Precision Prep'
    end
    name
  end

  def content_directory
    name = ''
    if self.offering_type == 'O'
      name = 'offerings/'
    elsif self.offering_type == 'W'
      name = ''
    elsif self.offering_type == 'E'
      name = 'tools/'
    elsif self.offering_type == 'T'
      name = 'testimonials/'
    elsif self.offering_type == 'P'
      name = 'partners/'
    elsif self.offering_type == 'A'
      name = 'partners/'
    elsif self.offering_type == 'M'
      name = 'mission/'
    elsif self.offering_type == 'R'
      name = 'research/'
    elsif self.offering_type == 'G'
      name = 'grant/'
    elsif self.offering_type == 'Q'
      name = 'marque/'
    elsif self.offering_type == 'C'
      name = 'team/'
    elsif self.offering_type == 'I'
      name = 'pm/'
    elsif self.offering_type == 'Z'
      name = 'team/'
    elsif self.offering_type == 'PP'
      name = 'prep/'
    end
    name
  end

  def page_view
    log = self.offering_logs.current
    if log.nil?
      log = OfferingLog.new
      log.period = current_period
      self.offering_logs << log
    else
      log.update_attribute(:counter, (log.counter + 1))
    end
  end

  private

  def current_period
    Date.current.year.to_s + Date.current.month.to_s
  end

  def current_mission
    Offering.missions.active.first rescue nil
  end

end
