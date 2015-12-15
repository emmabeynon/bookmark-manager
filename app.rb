require 'sinatra/base'
require_relative 'models/link'

class MyApp < Sinatra::Base
  get '/' do
    'My Bookmarks!'
  end

  get '/links' do
    erb(:view)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
