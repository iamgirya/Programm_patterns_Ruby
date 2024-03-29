require_relative './student_db.rb'
require_relative '../models/student/student.rb'

class StudentsListDB
  private_class_method :new

  def self.get_student(id)
    Student.from_json(StudentsListDB.database.select_by_id(id))
  end

  def self.remove_student(id)
    StudentsListDB.database.remove_by_id(id)
  end

  def self.replace_student(id, student)
    StudentsListDB.database.replace_by_id(id, student.to_s)
  end

  def self.add_student(student)
    StudentsListDB.database.add_student(student.to_s)
  end

  def self.get_students_slice(k, count, data)
    from = [(k-1) * count, self.count].min
    to = [self.count, from + count].min

    data.replace_objects(StudentsListDB.database.select_students(from, to).map { |x| Student.from_json(x) })
  end

  def self.count
    StudentsListDB.database.count
  end

  def self.database
    @database ||= StudentsDB.new
    @database
  end
end