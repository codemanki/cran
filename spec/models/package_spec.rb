require 'spec_helper'

describe Package do
  it { should have_many(:versions) }
  
  before :all do
    @package_data = {"Package" => "A3"}
  end

  it "should create package" do
    Package.update_package(@package_data).should_not be_nil
  end
  
  it "should not recreate package" do 
      package = Package.update_package(@package_data)
      package_again = Package.update_package(@package_data)
      
      package_again.should eql package
  end
  
  it "should create package from scratch" do 
    path = File.dirname(__FILE__) + '/../../test/package_files/'
    package_parsed = CranApi::PackageApi.parse_package_description(File.read("#{path}DESCRIPTION_2.txt"))
    package = Package.update_package(package_parsed)
    package.add_version(package_parsed)
    
    package.versions.length.should eql 1
  end
end
