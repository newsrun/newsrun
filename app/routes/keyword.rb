


class GenApp < Sinatra::Base

  get '/test_keyword' do 
   	kh = Keyword_Helper.new
    @keywords = kh.get_keywords(15)
    erb :keyword_test
  end
end
