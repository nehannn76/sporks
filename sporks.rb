require 'sinatra'
require 'haml'
require 'json'

get '/' do
  haml :index, :format => :html5
end

get '/customers' do
  data = JSON.parse(File.read('testdata.json'))
  haml :customers, :format => :html5, :locals => {:customers => data}
end
