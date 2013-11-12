# encoding: utf-8
class MyApp < Sinatra::Application
  get '/' do
    @groups = Group.all
    haml :index
  end
end
