class Bookmarks < Sinatra::Base
  
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

end
