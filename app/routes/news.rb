


class GenApp < Sinatra::Base

  get '/test' do
    News.delete_all
    helper = News_Helper.new
    helper.create_recode
    @events = News.all
    erb :news_test

  end

end
