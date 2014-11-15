module FetchNews 
	require 'net/http'
	require 'json'	

	def fetch_from_asahi_api2(query) 
	  url = URI.parse(URI.encode("http://54.64.121.212/search?ackey=ff28f1ffb1c51e8112e172fb45ba92ab553c7507&wt=json&q=#{query}"))
	  req = Net::HTTP::Get.new(url.to_s)
	  res = Net::HTTP.start(url.host, url.port) {|http|
	    http.request(req)
	  }
	  object = JSON.parse(res.body)

	  object['response']['result']['doc']
	end


	def fetch_from_asahi_api(&b)
		param = Param.new
		b.call(param)
		url = URI.parse param.url_string 
	  	req = Net::HTTP::Get.new url.to_s
	  	res = Net::HTTP.start(url.host, url.port) {|http|
	    	http.request(req)
	  	}
	  	object = JSON.parse(res.body)

	  	object['response']['result']['doc']

	end

end

class Param
	attr_accessor :q, :ackey, :sort, :start, :rows, :wt
	
	def initialize
	   	@q = 'Title:*'
		@ackey='ff28f1ffb1c51e8112e172fb45ba92ab553c7507'
		@sort='ReleaseDate desc'
		@start='1'
		@rows='1'
		@wt='json'
  	end	


	def url_string
		p instance_variables 
		params = instance_variables.map do |var|
			val = instance_variable_get var
			"#{var[1..-1]}=#{val}"
		end
	    URI.encode "http://54.64.121.212/search?#{params.join'&'}"
	end
end


