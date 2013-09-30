require 'spec_helper'

describe "the JetFuel app" do
  describe "GET '/'" do
    it "renders the home page" do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match("URL Shortening Service")
    end
  end

  describe "POST '/'" do
    context "with valid attribues" do
      it "re-renders the home page with the shortened url" do
        post '/', shorten: "www.example.com/thing/1"
        expect(last_response.body).to match(/jet\.com\/\w+/)
      end
    end

    context "with invalid attributes" do
    end
  end
end
