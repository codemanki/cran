require 'spec_helper'

describe "packages/new" do
  before(:each) do
    assign(:package, stub_model(Package).as_new_record)
  end

  it "renders new package form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => packages_path, :method => "post" do
    end
  end
end
