require 'spec_helper'

describe "packages/show" do
  before(:each) do
    @package = assign(:package, stub_model(Package))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
