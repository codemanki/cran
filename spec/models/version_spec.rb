require 'spec_helper'

describe Version do
  it "should create package from scratch" do 
    path = File.dirname(__FILE__) + '/../../test/package_files/'
    package_parsed = CranApi::PackageApi.parse_package_description(File.read("#{path}DESCRIPTION_2.txt"))
    package = Package.update_package(package_parsed)
    package.add_version(package_parsed)
    
    version = package.versions.first
    version.maintainers.count.should eql 1
    version.authors.count.should eql 4
  end
end
