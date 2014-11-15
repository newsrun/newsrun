class Analysis_Helper
	require_relative 'places'


	def analyze_keywords (s)
		json_obj = analysis_api s
		p = get_phrases json_obj 
	 	check_whether_keywords p
	end


	def analysis_api (s)
		url = URI.parse(URI.encode("https://lr.capio.jp/webapis/iminos/synana_k/1_1/?sent=#{s}&acckey=GRUCAQ2WevUZa72o"))
 		http = Net::HTTP.new(url.host, url.port)
  		http.use_ssl = true
  		request = Net::HTTP::Get.new(url.request_uri)
		response = http.request(request)
  		object = JSON.parse response.body
  		object
	end

	def get_phrases (json_obj)
		phrases = []

  		json_obj['results'].each do |result|
    		result['phrases'].each do |phrase|
      
	      		if phrase['jhinshi'] == '名詞'
		      	  	phrases << phrase['jgokan']				
	      		end
    		end if not result.nil? and not result['err'] == '1'
    	end
    	phrases
  	end

  	def check_whether_keywords (kws)
  		keywords = {}
  		kws.each do |kw|
  			keywords['place'] = kw if is_a_place? kw
  			keywords['matsuri'] = kw if is_a_matsuri? kw
  			keywords['date'] = kw if is_a_date? kw
  		end
  		keywords
  	end	

	
	def is_a_place? (s)
 		['','県','都','府','市','町'].each do |postfix|
 			if $JAPAN_PLACES[s+postfix]	
 				return true
 			end
 		end
 		return false
	end

	def is_a_matsuri? (s)
		s =~ /祭/

	end

	def is_a_date? (s)
		s =~ /月.+日/
	end	
end
