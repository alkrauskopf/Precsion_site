require 'rails_helper'

RSpec.describe "user_classes/show", type: :view do
  before(:each) do
    @user_class = assign(:user_class, UserClass.create!(
      :abbrev => "Abbrev",
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Abbrev/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
