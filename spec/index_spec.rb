require 'spec_helper'

describe 'EDD System' do
  include Rack::Test::Methods
  it 'should can access home page' do
    get '/'
    puts last_response
    last_response.should be_ok
  end

end