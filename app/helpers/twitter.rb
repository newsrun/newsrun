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
    tarr = Array.new
    client.search(key, result_type: "recent").take(100).each do |tweet|
      if tweet.media != nil
        tweet.media.each do |m|
          pics = nil
          
          if m != nil
            pics = Array.new
            if  m.attrs.has_key? :media_url
              pics.push({:pic => m.attrs[:media_url]})
              
            end
          end
          if pics != nil
            tarr.push({:text => tweet.full_text, :created_at => tweet.created_at, :pics => pics});
          end
          if (tarr.length >= 10) 
            break
          end
        end
      end
    end
    tarr
  end
end

debug = true
if debug
  helper = Twitter_Helper.new
  key = "紅葉"
  puts helper.search key
end
