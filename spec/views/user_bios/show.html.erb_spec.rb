require 'rails_helper'

RSpec.describe "user_bios/show", type: :view do
  before(:each) do
    @user_bio = assign(:user_bio, UserBio.create!(
      :education => "Education",
      :history => "History",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Education/)
    expect(rendered).to match(/History/)
    expect(rendered).to match(//)
  end
end
