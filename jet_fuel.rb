require 'sinatra'
require './jet_fuel/persisted_uri'
require './jet_fuel/uri_shortener'

class JetFuel < Sinatra::Base
  get '/' do
    uris = PersistedURI.all_urn_suffix.map { |urn_suffix| "#{request.url}rd/#{urn_suffix}" }
    erb :index , locals: { uris: uris }
  end

  post '/' do
    short_urn = URIShortener.new.shorten(params["uri_to_shorten"])
    PersistedURI.new(short_urn: short_urn, long_uri: params["uri_to_shorten"]).save
    redirect '/'
  end

  # Shortened URNs begin with a digit, followed by random url safe chars
  get %r{/(\d+\w*)} do |short_urn|
    uri = PersistedURI.find_by_urn(short_urn)
    redirect uri.long_uri
  end
end
