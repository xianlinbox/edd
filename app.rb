# encoding: utf-8
require 'sinatra'
require 'haml'

class MyApp < Sinatra::Application
  enable :sessions
  set :service_types, ['URL', 'DB', 'REST', 'SOAP', 'MQ', 'Custom']
  set :db_types, ['ORACLE', 'MYSQL', 'DB2', 'SQL_SERVER', 'PostgreSQL']

  get '/' do
    @groups = Group.all
    @service_types = settings.service_types
    @db_types = settings.db_types
    haml :index
  end

  post '/group' do
    new_group = Group.create(:name => params[:group_name])
    new_group.save
    redirect '/'
  end

  post '/url_dependency' do
    puts "************"+params[:group_id]

    group = Group.get(params[:group_id])
    url_dependency = UrlDependency.create(:name => params[:dependency_name],
                                          :url => params[:url],
                                          :schedule => params[:schedule],
    )
    group.url_dependencies << url_dependency
    group.save
    redirect '/'
  end
end

require_relative 'models/init'