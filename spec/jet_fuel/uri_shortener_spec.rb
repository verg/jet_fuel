require_relative '../../jet_fuel/uri_shortener'
require_relative '../../jet_fuel/persisted_uri'

describe URIShortener do
  let(:urn_generator) { double(call: "xyz_urn") }

  it "returns a shortend url with a random URN" do
    shortener = URIShortener.new( { urn_generator: urn_generator } )
    expect(shortener.shorten("http://example.com/thing")).to eq "xyz_urn"
  end

  it "creates unique URN" do
    shortener = URIShortener.new
    expect(shortener.shorten("xyz.io")).not_to eq shortener.shorten("abc.io")
  end

  it "doesn't create duplicate URN" do
    urn_generator = double
    urn_generator.stub(:call).and_return("duplicate_urn", "uniq_urn")

    database = double
    database.stub(:find_by_urn).with("duplicate_urn") { double("truthy thing") }
    database.stub(:find_by_urn).with("uniq_urn") { nil }

    shortener = URIShortener.new(urn_generator: urn_generator, database: database)

    uri = shortener.shorten(double)

    expect(uri).not_to match /duplicate_urn/
    expect(uri).to match /uniq_urn/
  end

  it "always begins URIs with numbers" do
    3.times do
      shortener = URIShortener.new
      expect(shortener.shorten("http://example.com/thing")).to match(/\A\d+/)
    end
  end
end
