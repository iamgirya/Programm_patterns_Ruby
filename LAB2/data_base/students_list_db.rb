require_relative './student_db.rb'

class StudentsListDB
  private_class_method :new

  def self.get_student(id)
    Student.from_json(StudentsListDB.database.select_by_id(id))
  end

  def self.remove_student(id)
    StudentsListDB.database.remove_by_id(id)
  end

  def self.replace_student(id, student)
    StudentsListDB.database.replace_by_id(is, student.as_json)
  end

  def self.add_student(student)
    StudentsListDB.database.add_student(student.as_json)
  end

  def self.get_students_slice(k, count, data)
    from = [k * count, self.count].min
    to = [self.count, from + count].min

    StudentsListDB.database.select_students(from, to).map { |x| Student.from_json(x) }
  end

  def self.count
    StudentsListDB.database.count
  end

  private def self.database
    @database ||= StudentsDB.new
    @database
  end
end