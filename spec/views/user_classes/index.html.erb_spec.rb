require 'rails_helper'

RSpec.describe "user_classes/index", type: :view do
  before(:each) do
    assign(:user_classes, [
      UserClass.create!(
        :abbrev => "Abbrev",
        :name => "Name",
        :description => "MyText"
      ),
      UserClass.create!(
        :abbrev => "Abbrev",
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of user_classes" do
    render
    assert_select "tr>td", :text => "Abbrev".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
