# encoding: utf-8
require 'sinatra'
require 'haml'

class MyApp < Sinatra::Application
  enable :sessions

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end
end

require_relative 'models/init'
require_relative 'routes/init'