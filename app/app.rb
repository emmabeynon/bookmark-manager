ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'data_mapper_setup'

require_relative 'controllers/links'

class Bookmarks < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  register Sinatra::Partial
  use Rack::MethodOverride
  set :session_secret, 'double super secret'
  set :partial_template_engine, :erb

  enable :partial_underscores

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    erb :index
  end

  post '/users' do
    @user = User.create(name: params[:name],
                       email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/links'
    else
      flash[:errors] = @user.errors.full_messages
      redirect 'users/new'
    end
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/links'
    else
      flash[:errors] = ['The email or password is incorrect']
      redirect '/sessions/new'
    end
  end

  delete '/sessions/' do
    session[:user_id] = nil
    flash.keep[:goodbye] = 'Goodbye!'
    redirect '/links'
  end

  # get '/links' do
  #   @links = Link.all
  #   erb(:'links/index')
  # end
  #
  # get '/links/new' do
  #   erb(:'links/new')
  # end
  #
  # post '/links' do
  #   link = Link.new(title: params[:title], url: params[:url])
  #   params[:tags].split(', ').each do |tag|
  #     link.tags << Tag.create(name: tag)
  #   end
  #   link.save
  #   redirect '/links'
  # end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb(:'links/index')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end