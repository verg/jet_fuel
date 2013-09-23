require 'sinatra'

class JetFuel < Sinatra::Base
  get '/' do
    erb :index
  end
end
