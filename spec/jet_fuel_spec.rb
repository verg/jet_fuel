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
      it "persists the uri" do
        uri = "www.example.com/thing/1"
        PersistedURI.any_instance.should_receive(:save)
        post '/', shorten: uri
      end

      it "re-renders the home page with the shortened url" do
        post '/', uri_to_shorten: "www.example.com/thing/1"
        follow_redirect!
        expect(last_request.url).to eq 'http://example.org/'
      end
    end

    context "with invalid attributes" do
    end
  end

  describe "GET '/rd/:short_urn'" do
    context "when the urn exists in the db" do
      it 'redirects to the orginal url' do
        long_uri = "http://example.org/"
        PersistedURI.stub(:find_by_urn).with("exmpl") { long_uri }
        get '/rd/exmpl'
        follow_redirect!
        expect(last_request.url).to eq long_uri
      end
    end

    context "when the urn doesn't exist in the db" do
      it 'redirects to the home page'
      it "flashes a message that the url doesn't exist"
    end
  end
end
