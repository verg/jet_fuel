require_relative "../../jet_fuel/persisted_uri"

describe PersistedURI do
  before do
    PersistedURI.destroy_all
  end

  it "writes a uri to the database" do
    uri = PersistedURI.new(short_urn: "exmpl",
                           long_uri: "example.com/urn").save
    expect(PersistedURI.find_by_urn("exmpl")).to eq uri
  end

  it "retreives persited URIs by url name" do
    uri = PersistedURI.new(short_urn: "exmpl",
                           long_uri: "example.com/urn").save
    other_uri = PersistedURI.new(short_urn: "other",
                                 long_uri: "example.com/other_urn").save
    expect(PersistedURI.find_by_urn("exmpl")).to eq uri
  end

  it "records when the uri was generated" do
    yesterday = double("yesterday")
    uri = PersistedURI.new(short_urn: "exmpl" ,
                           long_uri: "example.com/other_urn",
                           created_at: yesterday)
    expect(uri.created_at).to eq yesterday
  end

  it "has zero clicks initially" do
    uri = PersistedURI.new(short_urn: "exmpl" ,
                           long_uri: "example.com/other_urn")
    expect(uri.click_count).to eq 0
  end

  it "updates the click count" do
    uri = PersistedURI.new(short_urn: "exmpl", long_uri: "example.com/other_urn")
    uri.increment_click_count
    expect(uri.click_count).to eq 1
  end

  describe ".all_short_urn" do
    it 'retreives all the uris endings from the db' do
      uri = PersistedURI.new(short_urn: "exmpl",
                             long_uri: "example.com/urn").save
      other_uri = PersistedURI.new(short_urn: "other",
                                   long_uri: "example.com/other_urn").save
      expect(PersistedURI.all_short_urn).to include("exmpl", "other")
    end

    it 'returns an empty array when there are no uris persisted' do
      expect(PersistedURI.all_short_urn).to eq []
    end
  end

  describe ".all" do
    it 'retreives all the uris endings from the db' do
      uri = PersistedURI.new(short_urn: "exmpl",
                             long_uri: "example.com/urn").save
      other_uri = PersistedURI.new(short_urn: "other",
                                   long_uri: "example.com/other_urn").save
      expect(PersistedURI.all).to include(uri, other_uri)
    end

    it 'returns an empty array when there are no uris persisted' do
      expect(PersistedURI.all).to eq []
    end
  end
end
