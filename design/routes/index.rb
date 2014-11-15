
class GenApp < Sinatra::Base

  get '/:id' do
    haml "index#{params[:id]}".to_sym
  end
  
end
