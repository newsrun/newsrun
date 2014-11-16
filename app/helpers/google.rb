# -*- coding: utf-8 -*-

require 'googlestaticmap'

class Google_Map_Helper

  def get_map (config = {"zoom" => 11})
    location = MapLocation.new(:latitude => config['latitude'], :longitude => config['longitude'])
    map = GoogleStaticMap.new(:zoom => config['zoom'], :center => location)

    map.get_map
  end

  def get_img_url (config = {"zoom" => 11})
    location = MapLocation.new(:latitude => config['latitude'], :longitude => config['longitude'])
    map = GoogleStaticMap.new(:zoom => config['zoom'], :center => location)

    map.url(config["type"])
  end

  def set_markers_map(markers)

    map = GoogleStaticMap.new
    markers.each do |marker|
      map.markers << MapMarker.new(marker)
    end

    map.url
  end

  def set_marker_map(config)
    location = MapLocation.new(:latitude => config['latitude'], :longitude => config['longitude'])
    map = GoogleStaticMap.new(:zoom => config['zoom'], :center => location)

    map.markers << MapMarker.new(config['marker'])

    map.url
  end


end

# Test

def get_map_test
  helper = Google_Map_Helper.new

  config = {"latitude" => "35.6091172", "longitude" => "139.7733262", "zoom" => 11}

  puts helper.get_map(config)
end

def get_img_url_test
  helper = Google_Map_Helper.new

  config = {"latitude" => "35.6091172", "longitude" => "139.7733262", "zoom" => 11}

  puts helper.get_img_url(config)
end

def set_markers_get_map_test
  helper = Google_Map_Helper.new

  markers = Array.new

  markers << {:color => 'blue', :location => MapLocation.new(:latitude => "35.6091172", :longitude => "139.7733262")}
  markers << {:color => 'red', :location => MapLocation.new(:latitude => "35.6696642", :longitude => "139.7803643")}

  puts helper.set_markers_map(markers)
end

def set_marker_map_test
  helper = Google_Map_Helper.new

  config = {"latitude" => "35.6091172", "longitude" => "139.7733262", "zoom" => 11}

  config['marker'] = {:color => 'red', :location => MapLocation.new(:latitude => "35.6091172", :longitude => "139.7733262")}

  puts config

  puts helper.set_marker_map(config)
end

debug = false
if debug
  get_map_test

  get_img_url_test

  set_markers_get_map_test

  set_marker_map_test

end
