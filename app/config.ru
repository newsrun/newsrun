require File.join(File.dirname(__FILE__), 'app.rb')
map "/sounds" do
    run Rack::Directory.new("./public/sounds")
end
run GenApp.new
