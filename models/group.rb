class Group
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :create_at, DateTime, :default => Time.now

  has n, :url_dependencies
end