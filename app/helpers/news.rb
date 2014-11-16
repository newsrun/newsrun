
# -*- coding: utf-8 -*-


require_relative 'fetch_news'

class News_Helper
  include FetchNews
  attr_accessor :count

  def initialize 
    @count = 1
  end

  def create_recode
    recodes = fetch_from_asahi_api do |params|
      params.start = '1'
      params.rows = '20'
      params.q = 'Title:*祭り*'
    end

    recodes.each do |rec|

      News.create do |t|
          t.Title = rec['Title']
          t.Body = rec['Body']
          t.Url = rec['Url']
          t.ReleaseDate = rec['ReleaseDate']
          t.PhotoLink = rec['PhotoLink'].to_json
          #t. = recode['']
      end
    end
  end

  
  def fetch_next 
    recodes = fetch_from_asahi_api do |params|
      params.start = "#{@count}"
      params.rows = '1'
      params.q = 'Title:*祭り*'  
    end
    @count += 1 
    recodes[0]
  end


  def store (rec)
    News.create do |t|
      t.Title = rec['Title']
      t.Body = rec['Body']
      t.Url = rec['Url']
      t.ReleaseDate = rec['ReleaseDate']
      t.PhotoLink = rec['PhotoLink'].to_json
      #t. = recode['']       
    end
  end


  def search_all
    News.all
  end

  def asahi_api(query)
    url = URI.parse(URI.encode("http://54.64.121.212/search?ackey=ff28f1ffb1c51e8112e172fb45ba92ab553c7507&wt=json&q=#{query}"))
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    object = JSON.parse(res.body)

    object['response']['result']['doc']
  end



end
