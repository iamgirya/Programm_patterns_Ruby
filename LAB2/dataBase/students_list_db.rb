require_relative './student_db.rb'

class StudentsListDB
  private_attr_accessor :database

  def initialize()
    self.database = StudentsDB.new()
  end

  def get_student(id)
    Student.from_json(database.select_by_id(id))
  end

  def remove_student(id)
    database.remove_by_id(id)
  end

  def replace_student(id, student)
    database.replace_by_id(is, student.as_json)
  end

  def add_student(student)
    database.add_student(student.as_json)
  end

  def get_students_slice(k, count, data)
    from = [k * count, self.count()].min
    to = [self.count(), from + count].min

    database.select_students(from, to).map { |x| Student.from_json(x) }
  end

  def count()
    database.count()
  end

end