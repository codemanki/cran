require 'spec_helper'

describe "versions/new" do
  before(:each) do
    assign(:version, stub_model(Version).as_new_record)
  end

  it "renders new version form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => versions_path, :method => "post" do
    end
  end
end
