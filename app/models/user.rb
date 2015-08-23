class User < ActiveRecord::Base
  has_secure_password

  has_one :user_bio, dependent: :destroy

  has_many :user_authorizations, dependent: :destroy
  has_many :authorizations, through: :user_authorizations

  validates_format_of :email, :with => /\A[\w._%+-]+@[\w.-]+\.[\w]{2,6}\z/, :message => 'invalid format',
                      :allow_nil => false

  validates_uniqueness_of :email

  def self.last_first
    order('created_at DESC')
  end

  def self.by_last_name
    order('last_name ASC')
  end

  def full_name
    [self.first_name, self.last_name].join(' ')
  end

  # User.authorizations.
  def admin?
    self.authorizations.include?(Authorization.admin) ? true : false
  end

  def self.admins
    User.all.select{ |u| u.admin? }
  end

  def contactee?
    self.is_contactee
  end

  def self.contactees
    where(is_contactee: true)
  end

  def self.contact_list
    self.contactees.map(&:email).join(', ')
  end

end
