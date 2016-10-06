class User < ActiveRecord::Base
  has_secure_password

  belongs_to :user_class
  has_one :user_bio, dependent: :destroy

  has_many :user_authorizations, dependent: :destroy
  has_many :authorizations, through: :user_authorizations

  has_many :user_povs, dependent: :destroy

  validates_format_of :email, :with => /\A[\w._%+-]+@[\w.-]+\.[\w]{2,6}\z/, :message => 'invalid format',
                      :allow_nil => false

  validates_uniqueness_of :email


  def authorize!(auth_id)
    auth = UserAuthorization.new
    auth.authorization_id = auth_id
    self.user_authorizations << auth
  end

  def self.last_first
    order('created_at DESC')
  end

  def self.by_last_name
    order('last_name ASC')
  end

  def self.by_position
    order('display_position ASC')
  end

  def self.active
    where(is_active: true)
  end

  def full_name
    [self.first_name, self.last_name].join(' ')
  end

  def last_name_first
    [self.last_name, self.first_name].join(', ')
  end

  def name_with_prefix
    (self.prefix.nil? || self.prefix == '') ? self.full_name : (self.prefix + ' ' + self.full_name)
  end

  # User.authorizations.
  def admin?
    self.authorizations.include?(Authorization.admin) ? true : false
  end

  def team?
    self.authorizations.include?(Authorization.team) ? true : false
  end

  def self.admins
    User.all.select{ |u| u.admin? }
  end

  def self.team
    User.all.select{ |u| u.team? }
  end

  # User.user_classes

  def core?
    self.user_class && self.user_class.abbrev == 'core'
  end

  def consultant?
    self.user_class && self.user_class.abbrev == 'consult'
  end

  def self.full_team
    User.active.by_position.select{ |u| u.consultant? || u.core?}
  end

  def self.core_team
    User.active.by_position.select{ |u| u.core? }
  end

  def self.consultants
    User.active.by_position.select{ |u| u.consultant? }
  end

  def contactee?
    self.contactee == 'Yes'
  end

  def emailee?
    self.is_emailee
  end

  def active?
    self.is_active
  end

  def self.contactees
    where(contactee: 'Yes')
  end

  def self.emailees
    where(is_emailee: true)
  end

  def self.contact_list
    self.contactees.map(&:email).join(', ')
  end

  def self.with_povs
    User.select{|u| !u.user_povs.empty?}
  end

  def image
    !self.picture.empty? ? ("team/" + self.picture) : ''
  end

end
