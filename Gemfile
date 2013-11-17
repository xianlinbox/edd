source 'http://rubygems.org'
gem 'sinatra'
gem "nokogiri"
gem 'data_mapper'
gem 'haml'
gem 'faraday'
gem 'mysql'
gem 'ruby-oci8'

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

