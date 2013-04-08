class Version < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :package
  has_many :authors, :class_name => "Person", :conditions => {is_maintainer: false}
  has_many :maintainers, :class_name => "Person", :conditions => {is_maintainer: true}
  
  class << self
    
    def insert_version package, options
      existing = Version.where(version: options["Version"])
      return existing if existing.exists?

      version = Version.new
      version.package_id = package.id
      version.version = options["Version"]
      version.version_date = options["Date"].to_datetime
      version.title = options["Title"]
      version.description = options["Description"]
      version.license = options["License"]
      version.packaged = options["Packaged"].to_datetime
      version.published = options["Date/Publication"].to_datetime
      version.save!


      version.create_people(options["Author"])
      version.create_people(options["Maintainer"], true)
    end

  end
  
  def create_people people, is_maintainer = false
    persons = people.split(/,|and/)
    
    persons.each do |person|
      person.strip!
      attrs = {version_id: self.id, name: person, is_maintainer: is_maintainer}
      Person.where(attrs).first || Person.create(attrs)
    end
  end
  
end
