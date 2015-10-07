class Escent < ActiveRecord::Base

  validates_presence_of :escent_type
  validates_presence_of :url

  def self.by_position
    order('position ASC')
  end

  def self.by_type
    order('escent_type ASC')
  end

  def active?
    self.is_active
  end

  def self.active
    where('is_active = ?', true)
  end

  def main_page?
    self.escent_type == 'N'
  end

  def self.main_pages
    where('escent_type = ?', 'N').order('position ASC')
  end

  def type_name
    name = 'Unknown Type'
    if self.escent_type == 'N'
      name = 'Main Page'
    end
    name
  end

end
