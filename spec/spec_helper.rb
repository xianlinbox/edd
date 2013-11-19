require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'sinatra'
require 'rack/test'

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/spec/db/test.db")
  DataMapper.finalize.auto_upgrade!
end