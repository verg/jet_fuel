require_relative '../../jet_fuel/uri_shortener'

describe URIShortener do
  it "returns a shortend url with a random URN" do
    shortener = URIShortener.new("jet.com")
    expect(shortener.shorten("http://example.com/thing/1")).to match(/jet\.com\/\w+/)
  end

  it "creates unique uri" do
    #TODO think about how to handle same user creating duplicate URN
    shortener = URIShortener.new("jet.com")
    expect(shortener.shorten("x")).not_to eq shortener.shorten("y")
  end

  it "doesn't create duplicate uri if the generator initially creates a dup URN" do
    urn_generator = double
    urn_generator.stub(:call).and_return("duplicate_urn", "duplicate_urn", "uniq_urn")

    shortener = URIShortener.new("jet.com", urn_generator: urn_generator )
    first_uri = shortener.shorten(double)
    second_uri = shortener.shorten(double)
    expect(second_uri).not_to match /duplicate_urn/
    expect(second_uri).to match /uniq_urn/
  end

  it "returns the specified URN if given"

end
