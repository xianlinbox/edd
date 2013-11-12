# encoding: utf-8
class MyApp < Sinatra::Application
  post '/group' do

    haml :index
  end
end
