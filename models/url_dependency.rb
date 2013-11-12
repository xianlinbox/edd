class UrlDependency
  include DataMapper::Resource
  property :id, Serial
  property :url, String
  property :schedule, Integer
  property :create_at, DateTime, :default => Time.now
end