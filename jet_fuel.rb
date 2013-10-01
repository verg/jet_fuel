require 'sinatra'
require './jet_fuel/persisted_uri'
require './jet_fuel/uri_shortener'

class JetFuel < Sinatra::Base
  get '/' do
    uris = PersistedURI.all
    erb :index , locals: { uris: uris }
  end

  post '/' do
    short_uri = URIShortener.new("jet.io").shorten(params["uri_to_shorten"])
    PersistedURI.new(short_uri: short_uri, long_uri: params["uri_to_shorten"]).save
    redirect '/'
  end
end
