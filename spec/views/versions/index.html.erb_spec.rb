require 'spec_helper'

describe "versions/index" do
  before(:each) do
    assign(:versions, [
      stub_model(Version),
      stub_model(Version)
    ])
  end

  it "renders a list of versions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
