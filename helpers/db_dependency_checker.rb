require 'mysql'
require 'ruby-oci8'

module DBDependencyChecker
  def self.validate(db_dependency)
    send("validate_#{db_dependency.type}", db_dependency)
  end

  def self.validate_MYSQL(db_dependency)
    begin
      con = Mysql.new db_dependency.url, db_dependency.username, db_dependency.password
      rs = con.query 'SELECT VERSION()'
      puts rs.fetch_row
      "success"
    rescue Mysql::Error => e
      puts e.errno
      puts e.error
      "fail"
    ensure
      con.close if con
    end
  end

  def self.validate_ORACLE(db_dependency)
    begin
      con = OCI8.new(db_dependency.username, db_dependency.password).
      rs = con.query 'SELECT * FROM jobs ORDER BY 1'
      "success"
    rescue Mysql::Error => e
      puts e.errno
      puts e.error
      "fail"
    ensure
      con.close if con
    end
  end
end