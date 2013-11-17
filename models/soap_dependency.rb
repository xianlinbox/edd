class SoapDependency
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :description, String
  property :endpoint, String
  property :username, String
  property :password, String
  property :request, Text
  property :timeout, Integer
  property :schedule, Integer

  belongs_to :group
end