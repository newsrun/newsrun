require "json"
require_relative '../helpers/google'

class GenApp < Sinatra::Base

  get '/event' do
    @news = News.all

    google = Google_Map_Helper.new

    config = {"latitude" => "35.6168625", "longitude" => "139.7406247", "zoom" => 11}
    config['marker'] = {:color => 'red', :location => MapLocation.new(:latitude => "35.6168625", :longitude => "139.7406247")}

    @google_url = google.set_marker_map(config)

    twitter = Twitter_Helper.new
    key = "祭り"
    @twitters = twitter.search key

    @twitter_content = @twitters[0]
    @twitter_content[:pics] = @twitter_content[:pics][0][:pic]

    erb :index
  end

end
