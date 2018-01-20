require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "order_customer" do
    let(:mail) { UserMailer.order_customer }

    it "renders the headers" do
      expect(mail.subject).to eq("Order customer")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
