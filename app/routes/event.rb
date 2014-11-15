


class GenApp < Sinatra::Base

  get '/event' do
    @events = Event.all
    erb :event_test
  end

end
