class Bookmarks < Sinatra::Base

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(name: params[:name],
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

  get '/users/forgotten-password' do
    erb :'users/forgotten-password'
  end

  post '/users/forgotten-password' do
    user = User.first(email: params[:email])
    user.generate_token if user
    redirect '/users/recovery-confirmation'
  end

  get '/users/recovery-confirmation' do
    erb :'users/recovery-confirmation'
  end

  get '/users/reset-password' do
    @user = User.find_by_valid_token(params[:token])
    if @user
      erb :'/users/reset-password'
    else
      "Your token is invalid."
    end
  end

  patch '/users' do
    # require 'byebug'
    @user = User.find_by_valid_token(params[:token])
    # byebug
    @user.update(password: params[:password],
                password_confirmation: params[:password_confirmation])
    redirect '/users/reset-confirmation'
  end

  get '/users/reset-confirmation' do
    erb :'/users/reset-confirmation'
  end

end
