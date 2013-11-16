require File.dirname(__FILE__)+'/../../helpers/url_dependency_checker'

describe 'URL Dependency Checker' do
  it 'should success when validate baidu home page' do
    UrlDependencyChecker.validate("http://www.baidu.com").should eq 'success'
  end


  it 'should success when validate google home page' do
    UrlDependencyChecker.validate("http://www.google.com").should eq 'success'
  end

  it 'should fail when validate not exist page' do
    UrlDependencyChecker.validate("http://www.not_exist.com/not_exist").should eq 'fail'
  end

  it 'should fail when validate wrong format url' do
    UrlDependencyChecker.validate("asbc").should eq 'fail'
  end
end