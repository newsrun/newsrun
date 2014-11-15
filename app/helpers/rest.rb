require 'rest-client'

class Rest_Helper


  def get url, params
    client = RestClient::Resource.new url
    puts client.get(:params => params)
  end
  
  #def post url, params
    
end


test = false
if test
  params={
    :applicationId => '1065205457801855175',
    :format => 'json',
    :carrier => '0',
    :genre => 'all'
  }
  url = 'https://app.rakuten.co.jp/services/api/Travel/HotelRanking/20131024'
  
  helper = Rest_Helper.new 
  helper.get url, params
end
