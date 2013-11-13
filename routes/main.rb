# encoding: utf-8
class MyApp < Sinatra::Application
  get '/' do
    @groups = Group.all
    @service_types = settings.service_types
    @db_types = settings.db_types
    haml :index
  end
end
