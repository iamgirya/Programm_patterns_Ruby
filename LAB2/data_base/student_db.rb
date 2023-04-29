require 'mysql2'
require_relative "../support/meta_code"

class StudentsDB
  private_attr_accessor :db_connection

  def initialize
    self.db_connection = Mysql2::Client.new(:host => "localhost", :username => "root", :port => 3306, :password => 123123)
    self.db_connection.query('CREATE DATABASE IF NOT EXISTS my_db')
    self.db_connection.query('USE my_db')
    self.db_connection.query('DROP TABLE IF EXISTS student')
    self.db_connection.query(File.read('data_base/create_table.sql'))
    self.db_connection.query(File.read('data_base/insert.sql'))
  end

  def select_by_id(id)
    db_connection.query("SELECT * FROM student WHERE id = #{id}").map { |x| x }[0]
  end

  def remove_by_id(id)
    db_connection.query("DELETE FROM student WHERE id = #{id}")
  end

  def replace_by_id(id, student_json)
    result = JSON.parse(student_json)
    db_connection.query("DELETE FROM student WHERE id = #{id}")
    db_connection.query("""
            INSERT INTO student (id, last_name, first_name, paternal_name, git, phone, email, telegram) VALUES
            ROW(
                \"#{id}\",
                \"#{attr_or_null(result.delete('last_name'))}\",
                \"#{attr_or_null(result.delete("first_name"))}\",
                \"#{attr_or_null(result.delete("paternal_name"))}\",
                \"#{attr_or_null(result.delete("git"))}\",
                \"#{attr_or_null(result.delete("phone"))}\",
                \"#{attr_or_null(result.delete("email"))}\",
                \"#{attr_or_null(result.delete("telegram"))}\"
            )
            """)
  end

  def add_student(student_json)
    result = JSON.parse(student_json)
    db_connection.query("""
        INSERT INTO student (last_name, first_name, paternal_name, git, phone, email, telegram) VALUES
        ROW(
            \"#{attr_or_null(result.delete('last_name'))}\",
            \"#{attr_or_null(result.delete("first_name"))}\",
            \"#{attr_or_null(result.delete("paternal_name"))}\",
            \"#{attr_or_null(result.delete("git"))}\",
            \"#{attr_or_null(result.delete("phone"))}\",
            \"#{attr_or_null(result.delete("email"))}\",
            \"#{attr_or_null(result.delete("telegram"))}\"
        )
        """)
  end

  def select_students(from, to)
    db_connection.query("SELECT * FROM student LIMIT #{from}, #{to}")
  end

  def count()
    db_connection.query("SELECT count(*) FROM student").map { |x| x }[0]['count(*)']
  end

  private def attr_or_null(attr)
    if attr == nil
      "NULL"
    else
      attr
    end
  end
end