require 'faraday'

module SoapDependencyChecker
  def self.validate(soap_dependency)
    begin
      response = Faraday.new(:url => soap_dependency.endpoint).post do |req|
        req.options = {
            :timeout      => soap_dependency.timeout,
            :open_timeout => 10
        }
        req.headers['Content-Type'] = 'application/xml'
        req.body = soap_dependency.request
      end
      puts response.inspect
      response.status < 400 ? 'success' : 'fail'
    rescue => error
      puts error.inspect
      'fail'
    end
  end
end