require "rails_helper"

RSpec.describe UserNotifier, type: :mailer do
  describe "sign_up" do
    let(:mail) { UserNotifier.sign_up }

    it "renders the headers" do
      expect(mail.subject).to eq("Sign up")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
