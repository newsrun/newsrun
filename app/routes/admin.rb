

class GenApp < Sinatra::Base
  
  get '/admin/dashboard' do
    haml :dashboard, :layout => :admin_layout
  end
end
