require 'faraday'


module SoapDependencyChecker
  def self.validate(soap_dependency)
    begin

    rescue => error
      puts error.inspect
      'fail'
    end
  end
end