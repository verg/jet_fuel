require_relative "../../jet_fuel/persisted_uri"

describe PersistedURI do
  it "writes a uri to the database" do
    uri = PersistedURI.new(short_uri: "jet.io/exmpl",
                           long_uri: "example.com/urn").save
    expect(PersistedURI.find_by_uri("jet.io/exmpl")).to eq uri
  end

  it "retreives persited URIs by url name" do
    uri = PersistedURI.new(short_uri: "jet.io/exmpl",
                           long_uri: "example.com/urn").save
    other_uri = PersistedURI.new(short_uri: "jet.io/other",
                                 long_uri: "example.com/other_urn").save
    expect(PersistedURI.find_by_uri("jet.io/exmpl")).to eq uri
  end

  describe ".all" do
    it 'retreives all the uris from the db' do
      uri = PersistedURI.new(short_uri: "jet.io/exmpl",
                             long_uri: "example.com/urn").save
      other_uri = PersistedURI.new(short_uri: "jet.io/other",
                                   long_uri: "example.com/other_urn").save
      expect(PersistedURI.all).to include(uri, other_uri)
    end

    it 'returns an empty array when there are no uris persisted' do
      PersistedURI.destroy_all
      expect(PersistedURI.all).to eq []
    end
  end
end
