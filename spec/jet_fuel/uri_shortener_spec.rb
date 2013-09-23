require_relative '../../jet_fuel/uri_shortener'

describe URIShortener do
  it "returns a shortend url with a random URN" do
    shortener = URIShortener.new("jet.com")
    expect(shortener.shorten("http://example.com/thing/1")).to match(/jet\.com\/\w+/)
  end

  it "creates unique uri" do
    #TODO think about how to handle same user creating duplicate URN
    s = URIShortener.new("a.com")
    expect(s.shorten("x")).not_to eq s.shorten("y")
  end
  it "doesn't create duplicate uri if the generator initially creates a dup URN"

  it "returns the specified URN if given"

end
