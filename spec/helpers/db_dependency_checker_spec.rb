require File.dirname(__FILE__)+'/../../helpers/db_dependency_checker'
require File.dirname(__FILE__)+'/../../models/init'

require 'mysql'

describe 'DB Dependency Checker' do
  it 'should success when validate an exist mysql database' do
    db_dependency = DBDependency.create(:name => 'test',
                                        :url => 'localhost',
                                        :type => 'MYSQL',
                                        :username => 'edd',
                                        :password => 'edd123')
    DBDependencyChecker.validate(db_dependency).should eq 'success'
  end

  it 'should fail when validate an not exist mysql database' do
    db_dependency = DBDependency.create(:name => 'test',
                                        :url => 'remote',
                                        :type => 'MYSQL',
                                        :username => 'edd',
                                        :password => 'edd123')
    DBDependencyChecker.validate(db_dependency).should eq 'fail'
  end

  it 'should fail when validate mysql with wrong username' do
    db_dependency = DBDependency.create(:name => 'test',
                                        :url => 'remote',
                                        :type => 'MYSQL',
                                        :username => 'not_exist',
                                        :password => 'edd123')
    DBDependencyChecker.validate(db_dependency).should eq 'fail'
  end
end