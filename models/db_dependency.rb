class DBDependency
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :description, String
  property :type, String
  property :url, String
  property :username, String
  property :password, String
  property :table, String
  property :schedule, Integer
  property :create_at, DateTime, :default => Time.now
end