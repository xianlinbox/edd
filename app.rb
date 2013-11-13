# encoding: utf-8
require 'sinatra'
require 'haml'

class MyApp < Sinatra::Application
  enable :sessions
  set :service_types, ['URL','DB','REST','SOAP','MessageQueue','Custom']
  set :db_types, ['ORACLE','MYSQL','DB2','SQL_SERVER','PostgreSQL']

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end
end

require_relative 'models/init'
require_relative 'routes/init'