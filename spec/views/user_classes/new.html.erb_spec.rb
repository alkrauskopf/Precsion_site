require 'rails_helper'

RSpec.describe "user_classes/new", type: :view do
  before(:each) do
    assign(:user_class, UserClass.new(
      :abbrev => "MyString",
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new user_class form" do
    render

    assert_select "form[action=?][method=?]", user_classes_path, "post" do

      assert_select "input#user_class_abbrev[name=?]", "user_class[abbrev]"

      assert_select "input#user_class_name[name=?]", "user_class[name]"

      assert_select "textarea#user_class_description[name=?]", "user_class[description]"
    end
  end
end
