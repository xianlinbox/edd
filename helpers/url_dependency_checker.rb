require 'faraday'

module UrlDependencyChecker
  def self.validate(url_dependency)
    begin
      res = Faraday.get(url_dependency.url)
      res.status < 400 ? "success" : "fail"
    rescue => error
      puts error.inspect
      'fail'
    end
  end
end