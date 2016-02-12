class Offering < ActiveRecord::Base
  acts_as_tree

  has_many :offering_user_povs, dependent: :destroy
  has_many :user_povs, through: :offering_user_povs
  has_many :offering_images, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :stats, dependent: :destroy

  validates_presence_of :offering_type


  def self.all_parents
    where('parent_id IS NULL')
  end

  def children_by_position
    self.children.arrange_by_position
  end

  def images
    self.offering_images.active.by_position
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

  def self.arrange_by_position
    order('display_position ASC')
  end

  def self.by_type
    order('offering_type ASC')
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

  def mission?
    self.offering_type == 'M'
  end

  def research?
    self.offering_type == 'T'
  end

  def grant?
    self.offering_type == 'G'
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

  def self.missions
    where('offering_type = ?','M').order('display_position ASC')
  end

  def self.researches
    where('offering_type = ?','R').order('display_position ASC')
  end

  def self.grants
    where('offering_type = ?','G').order('display_position ASC')
  end

  def self.marque_stream
    self.marques.active.not_expired.empty? ? '' : (' . . . . ' + (self.marques.active.not_expired.map{|m| m.brief}.join(' . . . . ')).squeeze(" "))
  end

  def self.marques
    where('offering_type = ?','Q').order('display_position ASC')
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
    end
    name
  end
end
