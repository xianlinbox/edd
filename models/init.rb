# encoding: utf-8
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/development.db")
DataMapper::Property::String.length(255)

require_relative 'url_dependency'
require_relative 'group'