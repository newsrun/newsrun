require 'sinatra'
require 'sinatra/base'
require 'haml'
require 'active_record'
require_relative 'config/environments'
require_relative 'routes/init'
require_relative 'helpers/init'
require_relative 'models/init'

class GenApp < Sinatra::Base
  enable :method_override
  enable :sessions
  set :session_secret, 'super secret'
  
  configure do
    set :app_file, __FILE__
  end
  
  configure :development do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :qa do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :production do
    set :raise_errors, false
    set :show_exceptions, false
  end

end
