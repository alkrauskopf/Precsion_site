require 'rails_helper'

RSpec.describe "user_classes/edit", type: :view do
  before(:each) do
    @user_class = assign(:user_class, UserClass.create!(
      :abbrev => "MyString",
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit user_class form" do
    render

    assert_select "form[action=?][method=?]", user_class_path(@user_class), "post" do

      assert_select "input#user_class_abbrev[name=?]", "user_class[abbrev]"

      assert_select "input#user_class_name[name=?]", "user_class[name]"

      assert_select "textarea#user_class_description[name=?]", "user_class[description]"
    end
  end
end
