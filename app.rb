# encoding: utf-8
require 'sinatra'
require 'haml'
require 'sinatra/partial'
require File.dirname(__FILE__)+'/helpers/model_factory'

class MyApp < Sinatra::Application
  register Sinatra::Partial
  include ModelFactory
  enable :sessions
  set :service_types, ['URL', 'Database', 'REST', 'SOAP', 'MQ', 'Custom']
  set :db_types, ['ORACLE', 'MYSQL', 'DB2', 'SQL_SERVER', 'PostgreSQL']

  get '/' do
    @groups = Group.all
    @service_types = settings.service_types
    @db_types = settings.db_types
    haml :index
  end

  post '/groups' do
    new_group = Group.create(:name => params[:group_name])
    new_group.save
    redirect '/'
  end

  post '/dependencies' do
    puts "*****" + params[:group_id]
    puts "*****" + params[:service_type]
    puts "*****" + params[:monitor_title]
    puts "*****" + params[:monitor_description]
    puts "*****" + params[:url_monitor_url]
    send("create_#{params[:service_type]}_dependency", params)
    redirect '/'
  end

  get '/url_dependency/status/:id' do
    url_dependency = UrlDependency.get(params[:id])
    UrlDependencyChecker.validate(url_dependency)
  end
end

require_relative 'models/init'
require_relative 'helpers/init'