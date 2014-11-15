# -*- coding: utf-8 -*-
require 'yaml'
require 'twitter'

class Twitter_Helper
  def get_config
    config_path = File.join(File.dirname(__FILE__), '..', 'config', 'twitter.yml')
    config = (File.exists?(config_path) ? YAML.load_file(config_path) : nil)
  end
  
  def get_client
    conf = self.get_config
    config = {
      consumer_key: conf['api_key'],
      consumer_secret: conf['api_secret']
    }
    client = Twitter::REST::Client.new(config)
  end

  def search key, place = nil, count = nil
    client = self.get_client
    client.search(key, result_type: "recent").take(3).each do |tweet|
      puts tweet.text
    end
  end
end


helper = Twitter_Helper.new
key = "江ノ島"
helper.search key
