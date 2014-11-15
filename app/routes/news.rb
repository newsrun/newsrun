


class GenApp < Sinatra::Base

  get '/test_create' do
    News.delete_all
    helper = News_Helper.new
    helper.create_recode
    @events = News.all
    erb :news_test
  end

  get '/test_analysis' do 
  	news = News.all
  	helper = Analysis_Helper.new

  	@keywords = news.map{ |n|
  		helper.analyze_keywords(n.Title)
  	}	
  	erb :analysis_test
  end
end
