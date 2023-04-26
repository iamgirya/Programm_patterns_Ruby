require 'mysql2'

class StudentsDB
  attr_private_accessor :db_connection

  def initialize()
    self.db_connection = Mysql2::Client.new(:host => "localhost", :username => "root")
    self.db_connection.query('CREATE DATABASE IF NOT EXISTS my_db')
    self.db_connection.query('USE my_db')
    self.db_connection.query('DROP TABLE IF EXISTS student')
    self.db_connection.query(File.read('database/create_table.sql'))
    self.fill_data()
  end

  private def fill_data()
    db_connection.query(File.read('database/insert.sql'))
  end
end