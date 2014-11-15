require "json"

class GenApp < Sinatra::Base

  get '/event' do
    @news = News.all
    erb :index
  end

end
