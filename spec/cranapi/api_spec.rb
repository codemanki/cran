require "spec_helper"

describe "Api" do
  before :all do 
    path = File.dirname(__FILE__) + '/../../test/packages/'
    @package_1 = File.read(path + "packages_1.txt")
    @package_2 = File.read(path + "packages_2.txt")
  end
  
  it "should return empty array on no info" do
    CranApi.parse_packages("").should eql []
  end
  
  it "should return single package as array item with parsed info" do 
    package = CranApi.parse_packages(@package_1)
    package.should be_an_instance_of(Array)
    package.length.should eql 1
    
    package[0]["Package"].should eql "A3"
    package[0]["Version"].should eql "0.9.2"
    package[0]["Depends"].should eql "R (>= 2.15.0), xtable, pbapply"
    package[0]["Suggests"].should eql "randomForest, e1071"
    package[0]["License"].should eql "GPL (>= 2)"
    package[0]["NeedsCompilation"].should eql "no"
  end
  
  it "should return two packages" do 
    packages = CranApi.parse_packages(@package_2)
    packages.length.should eql 2
    
    packages[0]["Package"].should eql "A3"
    packages[1]["Package"].should eql "abc"
  end
  
  describe "using internets" do 
    before :all do 
      CranApi.stubs(:read_file_from_url).returns(@package_2)
    end
    
    it "grab packages" do
      packages = CranApi.grab_packages("http://google.com")
      packages.length.should eql 2

      packages[0]["Package"].should eql "A3"
      packages[1]["Package"].should eql "abc"
    end
  end
  
  describe "using packages" do 
    before :all do
      path = File.dirname(__FILE__) + '/../../test/package_files/'
      @package_a3 = Zlib::GzipReader.open(path + "A3_0.9.2.tar.gz")
      @package_description = File.read(path + "DESCRIPTION")
    end
    
    it "should parse package description" do 
      description_unparsed = CranApi::PackageApi.get_archived_package_description(@package_a3)
      package = CranApi::PackageApi.parse_package_description(description_unparsed)
     
      package["Package"].should eql "A3"
      package["Type"].should eql "Package"
      package["Title"].should =~ /A3: Accurate, Adaptable/
      package["Version"].should eql "0.9.2"
      package["Description"].should =~ /This package supplies tools/
      package["Date/Publication"].should eql "2013-03-26 19:58:40"
    end
    
  end
  
end