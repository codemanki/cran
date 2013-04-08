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
end
