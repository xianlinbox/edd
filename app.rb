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
    create_group(params)
    redirect '/'
  end

  post '/dependencies' do
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