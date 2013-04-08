require 'open-uri'
require "pp"
require "dcf"

require 'rubygems/package'
require 'zlib'

module CranApi
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
    
    ##for demo
    
    def grab_packages_locally
      contents = File.read(File.dirname(__FILE__) + '/../../test/packages/packages_couple.txt')
      parse_packages(contents)
    end
    
  end
  
  module PackageApi
    class PackagesInfoParsingError < StandardError; end
    
    class << self
      
      def grab_package_info options
        package_url = url_for_package options
        source = open(package_url)
        gz = Zlib::GzipReader.new(source)
        parse_package_description(get_archived_package_description(gz))
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
        package[0] || nil 
      end
      
      def url_for_package options
        "#{CRAN_CONFIG['url']}/#{options['Package']}_#{options['Version']}.tar.gz"
      end
 
    end
  end
  
  class Cran
    def update_packages
      url = "#{CRAN_CONFIG['url']}/PACKAGES"
      packages = CranApi::grab_packages_locally # CranApi::grab_packages(url)
      len = packages.length
      i = 0
      packages.each do |options|
         i += 1
         puts "Fetching package [#{i}/#{len}]"
         begin
           package = Package.update_package(options)
           package_description = PackageApi::grab_package_info(options)
           package.add_version(package_description)
        rescue 
          puts "Something is wrong, moving on"
        end
      end
    end
  end
end

