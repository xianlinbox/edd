require File.dirname(__FILE__)+'/../../models/init'
require File.dirname(__FILE__)+'/../spec_helper'
require File.dirname(__FILE__)+'/../../helpers/dependency_checker'

include DependencyChecker

describe "REST Dependency Checker" do

  it "should success when check " do
    params = {
        :group_name => 'Test'
    }
    create_group(params)
    Group.all.length.should eq 1
  end
end

