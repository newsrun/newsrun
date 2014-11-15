require 'yaml'
require_relative 'rest'

class Rakuten_Helper
  def get_config
    config_path = File.join(File.dirname(__FILE__), '..', 'config', 'rakuten.yml')
    config = (File.exists?(config_path) ? YAML.load_file(config_path) : nil)
  end
  
  def search_gis latitude, longitude, radius
    conf = self.get_config
    gis_url = conf['travel_gis_search']
    puts gis_url
    params = {
      :applicationId => conf['app_id'],
      :format => :json,
      :latitude => latitude,
      :longitude => longitude,
      :searchRadius => radius
    }
    resthelper = Rest_Helper.new
    result = resthelper.get gis_url, params
    
  end

  
end

debug = false

if debug
  helper = Rakuten_Helper.new
  puts helper.search_gis 128440.51, 503172.21, 1
end
