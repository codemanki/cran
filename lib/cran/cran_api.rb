require 'open-uri'
require "pp"
require "dcf"

require 'rubygems/package'
require 'zlib'

URL = "http://cran.r-project.org/src/contrib/"

module CranApi
  class PackagesListParsingError < StandardError; end
  
  class << self
    
    def grab_packages(url)
      contents = read_file_from_url(url)
      parse_packages(contents)
    end
  
    def read_file_from_url(url)
      open(url) {|f| f.read }
    end
    
    def parse_packages(content)
      return [] if !content || content.blank?
      Dcf.parse(content)
    end
  end
  
  module PackageApi
    class PackagesInfoParsingError < StandardError; end
    class << self
      
      def grab_package_info options
        package_url = url_for_package options
        source = open(package_url)
        gz = Zlib::GzipReader.new(source)
      end
      
      def get_archived_package_description gz
        Gem::Package::TarReader.new(gz).each do |entry|
          if(entry.file? && entry.full_name =~ /DESCRIPTION/)
            return entry.read
          end
        end
        
        return nil
      end
      
      def parse_package_description(content)
        package = Dcf.parse(content)
        return package[0] if package[0]
        return nil
      end
      
      def url_for_package options
        return "#{URL}/#{options.name}/#{options.version}"
      end
      
      
    end
  end
  
end