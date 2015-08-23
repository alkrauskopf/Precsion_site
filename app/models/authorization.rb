class Authorization < ActiveRecord::Base

  has_many :user_authorizations, dependent: :destroy
  has_many :users, through: :user_authorizations

  def self.admin
    where(name: 'admin').first_or_create
  end

end
