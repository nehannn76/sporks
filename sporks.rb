require 'sinatra'
require 'haml'
require 'json'
require 'redis'

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
    
    #TODO:  Cache login sessions using Redis
  end
end

get '/' do
  haml :index, :format => :html5
end

get '/customers' do
  protected!
  data = JSON.parse(File.read('testdata.json'))
  haml :customers, :format => :html5, :locals => {:customers => data}
end
