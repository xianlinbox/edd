require File.dirname(__FILE__)+'/../../helpers/url_dependency_checker'
require File.dirname(__FILE__)+'/../../models/init'

describe 'URL Dependency Checker' do
  it 'should success when validate baidu home page' do
    url_dependency = UrlDependency.create(:name => "test", :url => "http://www.baidu.com")
    UrlDependencyChecker.validate(url_dependency).should eq 'success'
  end


  it 'should success when validate google home redirect page' do
    url_dependency = UrlDependency.create(:name => "test", :url => "http://www.google.com")
    UrlDependencyChecker.validate(url_dependency).should eq 'success'
  end

  it 'should fail when validate not exist page' do
    url_dependency = UrlDependency.create(:name => "test", :url => "http://www.not_exist.com/not_exist")
    UrlDependencyChecker.validate(url_dependency).should eq 'fail'
  end

  it 'should fail when validate wrong format url' do
    url_dependency = UrlDependency.create(:name => "test", :url => "asbc")
    UrlDependencyChecker.validate(url_dependency).should eq 'fail'
  end
end