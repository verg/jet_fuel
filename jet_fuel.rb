require 'sinatra'

class JetFuel < Sinatra::Base
  match("URL Shortening Service") get '/' do
    erb :index
  end
end
