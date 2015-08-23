require 'rails_helper'

RSpec.describe "user_bios/edit", type: :view do
  before(:each) do
    @user_bio = assign(:user_bio, UserBio.create!(
      :education => "MyString",
      :history => "MyString",
      :user => nil
    ))
  end

  it "renders the edit user_bio form" do
    render

    assert_select "form[action=?][method=?]", user_bio_path(@user_bio), "post" do

      assert_select "input#user_bio_education[name=?]", "user_bio[education]"

      assert_select "input#user_bio_history[name=?]", "user_bio[history]"

      assert_select "input#user_bio_user_id[name=?]", "user_bio[user_id]"
    end
  end
end
