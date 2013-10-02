require 'sinatra'
require './jet_fuel/persisted_uri'
require './jet_fuel/uri_shortener'

class JetFuel < Sinatra::Base
  get '/' do
    uris = PersistedURI.all
    erb :index , locals: { uris: uris }
  end

  post '/' do
    short_urn = URIShortener.new.shorten(params["uri_to_shorten"])
    PersistedURI.new(short_urn: short_urn, long_uri: params["uri_to_shorten"]).save
    redirect '/'
  end

  get '/rd/:short_urn' do
    uri = PersistedURI.find_by_urn(params[:short_urn])
    redirect uri
  end
end
