ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

class Bookmarks < Sinatra::Base

  enable :sessions
  set :session_secret, 'double super secret'

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    erb :index
  end

  post '/users' do
    user = User.create(name: params[:name], password: params[:password], email: params[:email])
    session[:user_id] = user.id
    redirect '/links'
  end

  get '/users/new' do
    erb :'users/new'
  end

  get '/links' do
    @links = Link.all
    erb(:'links/index')
  end

  get '/links/new' do
    erb(:'links/new')
  end

  post '/links' do
    link = Link.new(title: params[:title], url: params[:url])
    params[:tags].split(', ').each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb(:'links/index')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
