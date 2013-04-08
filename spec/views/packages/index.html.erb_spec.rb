require 'spec_helper'

describe "packages/index" do
  before(:each) do
    assign(:packages, [
      stub_model(Package),
      stub_model(Package)
    ])
  end

  it "renders a list of packages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
