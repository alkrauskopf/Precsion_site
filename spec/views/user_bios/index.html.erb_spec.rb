require 'rails_helper'

RSpec.describe "user_bios/index", type: :view do
  before(:each) do
    assign(:user_bios, [
      UserBio.create!(
        :education => "Education",
        :history => "History",
        :user => nil
      ),
      UserBio.create!(
        :education => "Education",
        :history => "History",
        :user => nil
      )
    ])
  end

  it "renders a list of user_bios" do
    render
    assert_select "tr>td", :text => "Education".to_s, :count => 2
    assert_select "tr>td", :text => "History".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
