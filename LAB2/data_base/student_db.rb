require 'mysql2'

class StudentsDB
  private_attr_accessor :db_connection

  def initialize
    self.db_connection = Mysql2::Client.new(:host => "localhost", :username => "root")
    self.db_connection.query('CREATE DATABASE IF NOT EXISTS my_db')
    self.db_connection.query('USE my_db')
    self.db_connection.query('DROP TABLE IF EXISTS student')
    self.db_connection.query(File.read('database/scripts/create_table.sql'))
    self.fill_data
  end
  private def fill_data
    db_connection.query(File.read('database/scripts/fill_data.sql'))
  end

  def select_by_id(id)
    db_connection.query("SELECT * FROM student WHERE id = #{id}").map { |x| x }[0]
  end

  def remove_by_id(id)
    db_connection.query("DELETE FROM student WHERE id = #{id}")
  end

  def replace_by_id(id, student_json)
    db_connection.query("DELETE FROM student WHERE id = #{id}")
    db_connection.query("""
            INSERT INTO student (id, lastname, firstname, patronymic, git, phone, email, telegram) VALUES
            ROW(
                \"#{id}\",
                \"#{attr_or_null(student_json["lastname"])}\",
                \"#{attr_or_null(student_json["firstname"])}\",
                \"#{attr_or_null(student_json["patronymic"])}\",
                \"#{attr_or_null(student_json["git"])}\",
                \"#{attr_or_null(student_json["phone"])}\",
                \"#{attr_or_null(student_json["email"])}\",
                \"#{attr_or_null(student_json["telegram"])}\"
            )
            """)
  end

  def add_student(student_json)
    db_connection.query("""
        INSERT INTO student (lastname, firstname, patronymic, git, phone, email, telegram) VALUES
        ROW(
            \"#{attr_or_null(student_json["lastname"])}\",
            \"#{attr_or_null(student_json["firstname"])}\",
            \"#{attr_or_null(student_json["patronymic"])}\",
            \"#{attr_or_null(student_json["git"])}\",
            \"#{attr_or_null(student_json["phone"])}\",
            \"#{attr_or_null(student_json["email"])}\",
            \"#{attr_or_null(student_json["telegram"])}\"
        )
        """)
  end

  def select_students(from, to)
    db_connection.query("SELECT * FROM student LIMIT #{from}, #{to}")
  end

  def count()
    db_connection.query("SELECT count(*) FROM student")
  end

  private def attr_or_null(attr)
    if attr == nil
      "NULL"
    else
      attr
    end
  end
end