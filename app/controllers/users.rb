class Bookmarks < Sinatra::Base

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

end
