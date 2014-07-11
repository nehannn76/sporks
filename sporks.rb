require 'sinatra'
require 'haml'

get '/' do
  haml :index, :format => :html5
end

get '/customers' do
  haml :customers, :format => :html5
end
