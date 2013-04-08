require 'open-uri'
require "pp"
require "dcf"

module CranApi
  class PackageParsingError < StandardError; end
  class << self
    def grab_packages(url)
    
    end
  
    def parse_packages(content)
      return [] if !content || content.blank?
      packages = []
      
      no_yes_keys = ["no", "yes"]
      
      content.each_line do |line|
        parsed_line =  Dcf.parse(line)
        if parsed_line && parsed_line[0]
          entity = parsed_line[0]
          
          if(entity["Package"])
            packages << {name: entity["Package"]}
          else
            #Parse key
            key = entity.keys[0]
            sym = key.downcase.to_sym
            value = entity[entity.keys[0]]
            #if this is yes/no field, return boolean
            if no_yes_keys.include? value
              value = value == "yes" ? true : false
            end
            
            #something happened. Either no package element was created or 
            raise PackageParsingError, "I have key '#{key}' with value '#{value}' but previously there was no package " if !packages[packages.length - 1]
            raise PackageParsingError, "I have key '#{key}' with value '#{value}' but previously it was already defined with value '#{packages[packages.length - 1][sym]}'"  if packages[packages.length - 1][sym]
            packages[packages.length - 1][sym] = value
          end
        end
      end
      packages
    end
  end
end