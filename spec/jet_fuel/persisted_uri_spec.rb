require_relative "../../jet_fuel/persisted_uri"

describe PersistedURI do
  it "writes a uri to the database" do
    uri = PersistedURI.new("jet.io/example").save
    PersistedURI.find_by_uri("jet.io/example").to eq uri
  end

  it "retreives persited URIs"
end
