require 'sinatra'

class JetFuel < Sinatra::Base
  get '/' do
    "the hookup"
  end
end
