require 'faraday'

module UrlDependencyChecker
  def self.validate(url)
    begin
      res = Faraday.get(url)
      res.status < 400 ? "success" : "fail"
    rescue
      'fail'
    end
  end
end