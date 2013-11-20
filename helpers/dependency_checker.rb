require 'faraday'
require 'equivalent-xml'
require_relative '../models/init'

module DependencyChecker
  def check_url(dependency_id)
    url_dependency = UrlDependency.get(dependency_id)
    error_wrapper(url_dependency) do |dependency|
      res = Faraday.get(url_dependency.url)
      res.status < 400 ? "success" : "fail"
    end
  end

  def check_soap(dependency_id)
    soap_dependency = SoapDependency.get(dependency_id)
    error_wrapper(soap_dependency) do |dependency|
      conn = Faraday.new(:url => soap_dependency.endpoint)
      conn.basic_auth(soap_dependency.username, soap_dependency.password)
      response = conn.post do |req|
        req.options = {
            :timeout => soap_dependency.timeout,
            :open_timeout => 10
        }
        req.headers['Content-Type'] = 'application/xml'
        req.headers['a'] = 'application/xml'
        req.body = soap_dependency.request
      end
      EquivalentXml.equivalent?(response.body, soap_dependency.response) ? 'success' : 'fail'
    end
  end

  def error_wrapper(dependency)
    begin
      yield(dependency)
    rescue => error
      puts error.inspect
      'fail'
    end
  end
end