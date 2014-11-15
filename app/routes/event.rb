class GenApp < Sinatra::Base

  get '/event' do
    @events = Event.all
    erb :index
  end

end
