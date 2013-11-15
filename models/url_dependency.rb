class UrlDependency
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :description, String
  property :url, String
  property :schedule, Integer

  belongs_to :group
end