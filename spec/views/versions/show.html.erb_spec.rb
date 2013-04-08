require 'spec_helper'

describe "versions/show" do
  before(:each) do
    @version = assign(:version, stub_model(Version))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
