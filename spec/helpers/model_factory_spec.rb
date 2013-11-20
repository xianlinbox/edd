require File.dirname(__FILE__)+'/../../helpers/model_factory'
require File.dirname(__FILE__)+'/../../models/init'
require File.dirname(__FILE__)+'/../spec_helper'

include ModelFactory

describe "Model Factory" do
  before(:all) do
    UrlDependency.all.destroy
    Group.all.destroy
  end

  it "should create group" do
    params = {
        :group_name => 'Test'
    }
    create_group(params)
    Group.all.length.should eq 1
  end

  it "should insert url dependency into the database" do
    group_id = Group.all[0].id
    params = {
        :service_type => 'URL',
        :group_id => group_id,
        :monitor_title => 'Baidu',
        :monitor_description => 'test baidu home page',
        :url_monitor_url => 'http://www.baidu.com'
    }
    create_URL_dependency(params)
    UrlDependency.all(:group_id => group_id, :name => 'Baidu').length.should eq 1
  end


  it "should insert soap dependency into the database" do
    group_id = Group.all[0].id
    params = {
        :service_type => 'URL',
        :group_id => group_id,
        :monitor_title => 'Echo Service',
        :monitor_description => 'test soap service',
        :soap_monitor_endpoint => 'http://www.baidu.com',
        :soap_monitor_username => 'admin',
        :soap_monitor_password => 'admin',
        :soap_monitor_request => 'test',
        :soap_monitor_response => 'test'
    }
    create_SOAP_dependency(params)
    SoapDependency.all(:group_id => group_id, :name => 'Echo Service').length.should eq 1
  end
end
