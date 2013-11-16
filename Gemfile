source 'http://rubygems.org'
gem 'sinatra'
gem 'data_mapper'
gem 'haml'
gem 'faraday'

group :production do
  gem "pg"
  gem "dm-postgres-adapter"
end

group :development, :test do
  gem "sqlite3"
  gem "dm-sqlite-adapter"
  gem 'unicorn'
  gem 'rspec'
  gem 'rack'
  gem 'rack-test'
  gem 'ZenTest'
end

