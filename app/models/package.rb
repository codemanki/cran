class Package < ActiveRecord::Base
  attr_accessible :name
  has_many :versions, :dependent => :destroy
  
  class << self
    
    def update_package options
      Package.find_or_create_by_name(:name => options["Package"])
    end
    
  end
  
  def add_version options
    Version.insert_version(self, options)
  end
end
