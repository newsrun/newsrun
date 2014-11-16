class GenApp < Sinatra::Base

  get '/' do
    redirect to('/event')
  end

  get '/login' do
    erb :login
  end

  get '/register' do
    erb :register
  end

  post '/login' do
    if params[:email] == 'test@test.com' && params[:password] == '123456'
      session[:email] = params[:email]
      session[:user] = params[:email].split('@')[0]
      redirect '/'
    else
      redirect '/login'
    end
  end

  post '/register' do
    session[:email] = params[:email]
    session[:user]  = params[:name]

    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
