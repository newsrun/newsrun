require "json"
require_relative '../helpers/google'

class GenApp < Sinatra::Base

  get '/event' do
    @news = News.all

    @twitters = Array.new

    @news.each do |item|

      puts item.id
      google = Google_Map_Helper.new

      config = {"latitude" => "35.6168625", "longitude" => "139.7406247", "zoom" => 11}
      config['marker'] = {:color => 'red', :location => MapLocation.new(:latitude => "35.6168625", :longitude => "139.7406247")}

      @google_url = google.set_marker_map(config)

      twitter = Twitter_Helper.new
      keyword = Keywords.find(item.id)

      puts keyword.keyword
      puts keyword.place
      result = twitter.search "#{keyword.keyword} #{keyword.place}"
      if result.length == 0
        result = twitter.search keyword.keyword
        if result.length == 0
          result = twitter.search keyword.place
          if result.length == 0
            result = twitter.search "祭り"
          end
        end
      end

      twitters = result

      twitters_four = twitters[0..3]
      twitters_four.each_with_index do |twitter, index|
        twitters_four[index][:pics] = twitter[:pics][0][:pic]
      end
      @twitters.push(twitters_four)
    end

    erb :index
  end

end
