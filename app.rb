# encoding: utf-8
require 'sinatra'
require 'haml'
require 'sinatra/partial'
require 'dm-serializer'
require File.dirname(__FILE__)+'/helpers/model_factory'
require File.dirname(__FILE__)+'/helpers/dependency_checker'

class MyApp < Sinatra::Application
  register Sinatra::Partial
  include ModelFactory
  include DependencyChecker
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
    create_group(params)
    redirect '/'
  end

  post '/dependencies' do
    send("create_#{params[:service_type]}_dependency", params)
    redirect '/'
  end

  get '/dependency/status/:service_type/:id' do
    send("check_#{params[:service_type]}", params[:id])
  end

  get '/dependency/:service_type/:id' do
    dependency = send("get_#{params[:service_type]}_dependency", params[:id])
    dependency.to_json
  end

  get '/dependency/:service_type/:id/delete' do
    send("delete_#{params[:service_type]}_dependency", params[:id])
    redirect '/'
  end
end