class UrlDependency
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :url, String
  property :schedule, Integer
  property :create_at, DateTime, :default => Time.now
end