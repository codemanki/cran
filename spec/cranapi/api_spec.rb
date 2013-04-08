require "spec_helper"

describe "Api should" do
  before :all do 
    path = File.dirname(__FILE__) + '/../../test/packages/'
    @package_1 = File.read(path + "packages_1.txt")
    @package_2 = File.read(path + "packages_2.txt")
    @package_error_1 = File.read(path + "packages_error_1.txt")
    @package_error_2 = File.read(path + "packages_error_2.txt")
  end
  
  it "should return empty array on no info" do
    CranApi.parse_packages("").should eql []
  end
  
  it "should return single package as array item with parsed info" do 
    package = CranApi.parse_packages(@package_1)
    package.should be_an_instance_of(Array)
    package.length.should eql 1
    
    package[0][:name].should eql "A3"
    package[0][:version].should eql "0.9.2"
    package[0][:depends].should eql "R (>= 2.15.0), xtable, pbapply"
    package[0][:suggests].should eql "randomForest, e1071"
    package[0][:license].should eql "GPL (>= 2)"
    package[0][:needscompilation].should be_false
  end
  
  it "should return two packages" do 
    packages = CranApi.parse_packages(@package_2)
    packages.length.should eql 2
    
    packages[0][:name].should eql "A3"
    packages[1][:name].should eql "abc"
  end
  
  it "should throw an error because there is no package name" do
    expect { CranApi.parse_packages(@package_error_1)}.to raise_error(CranApi::PackageParsingError, /no package/)
  end
  
  it "should throw an error because key is defined twice for same package" do
    expect { CranApi.parse_packages(@package_error_2)}.to raise_error(CranApi::PackageParsingError, /already defined/)
  end
end