class Package < ActiveRecord::Base
  attr_accessible :name
  has_many :versions
  
  class << self
    
    def update_package options
      Package.find_or_create_by_name(:name => options["Package"])
    end
    
  end
  
end
