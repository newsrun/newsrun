
class GenApp < Sinatra::Base


  get '/signin' do
    haml :signin
  end
  get '/signup' do
    haml :signup
  end

  
  post '/signout' do
    
  end
  post '/signin' do
  end
  post '/signup' do
  end

end
