require 'rails_helper'

RSpec.describe "user_bios/new", type: :view do
  before(:each) do
    assign(:user_bio, UserBio.new(
      :education => "MyString",
      :history => "MyString",
      :user => nil
    ))
  end

  it "renders new user_bio form" do
    render

    assert_select "form[action=?][method=?]", user_bios_path, "post" do

      assert_select "input#user_bio_education[name=?]", "user_bio[education]"

      assert_select "input#user_bio_history[name=?]", "user_bio[history]"

      assert_select "input#user_bio_user_id[name=?]", "user_bio[user_id]"
    end
  end
end
