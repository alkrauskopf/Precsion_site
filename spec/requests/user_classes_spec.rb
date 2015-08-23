require 'rails_helper'

RSpec.describe "UserClasses", type: :request do
  describe "GET /user_classes" do
    it "works! (now write some real specs)" do
      get user_classes_path
      expect(response).to have_http_status(200)
    end
  end
end
