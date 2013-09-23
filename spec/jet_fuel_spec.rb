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
  end
end
