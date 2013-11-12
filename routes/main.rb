# encoding: utf-8
class MyApp < Sinatra::Application
  get '/' do
    haml :index
  end
end
