require "json"
require_relative '../helpers/google'

class GenApp < Sinatra::Base

  get '/event' do
    @news = News.all

    helper = Google_Map_Helper.new

    config = {"latitude" => "35.6168625", "longitude" => "139.7406247", "zoom" => 11}

    config['marker'] = {:color => 'red', :location => MapLocation.new(:latitude => "35.6168625", :longitude => "139.7406247")}

    @google_url = helper.set_marker_map(config)

    erb :index
  end

end
