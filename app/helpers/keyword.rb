class Keyword_Helper
	require_relative 'places'
	require_relative 'news'

	def get_keywords (n)
		News.delete_all
		count = 0
		results = []
		news_helper = News_Helper.new
		while count < n
			rec = news_helper.fetch_next
			keyword = extract_keywords_from_record rec
			if not keyword.nil?
				count += 1
				results << keyword
				news_helper.store rec
				store_keyword keyword
				#puts "=========== GET ==========="
				#puts keyword
			end
			#puts "=========== miss one ==========="
		end
		results	
	end

	def store_keyword(keyword)
		n = News.order('id desc').first
		Keywords.create do |t|
			t.place = keyword['place']
			t.date = keyword['date']
			t.keyword = keyword['keyword']
			t.news_id = n.id
		end
	end


	def extract_keywords_from_record(rec)		
		#puts "===================="
		#puts rec['Title']
		#puts rec['Body']
		p = get_phrases(analysis_api(rec['Title']))
		keyword = check_keyword_from_title p
        
       	return keyword if is_keyword_enough? keyword
       	#
        p = []
        sentences = rec['Body'].split("。")
        sentences.each do |sen|
    		p += get_phrases(analysis_api(sen))
    	end

		keyword  = append_keyword_from_body(p, keyword)
		return nil if not is_keyword_enough? keyword
		keyword
	end

	def is_keyword_enough? (keyword)
		return true if keyword.nil?

		if keyword['place'].nil? or keyword['keyword'].nil? or keyword['date'].nil?
			false
		else
			true
		end

	end

	def extract_keywords (s)
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

  	def check_keyword_from_title (kws)

  		return nil if kws.include? 'お祭りナビ'
  		keyword = {}
  		kws.each do |kw|
  			keyword['place'] = kw if is_a_place? kw
  			keyword['keyword'] = kw if is_a_matsuri? kw
  			keyword['date'] = kw if is_a_date? kw
  		end
  		keyword
  	end	

  	def append_keyword_from_body (kws, keyword)
  		keyword = {}
  		kws.each do |kw|
  			keyword['place'] ||= kw if is_a_place? kw
  			keyword['keyword'] ||= kw if is_a_matsuri? kw
  			keyword['date'] ||= kw if is_a_date? kw
  		end
  		keyword
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
