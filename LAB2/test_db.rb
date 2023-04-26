require './database/student_db.rb'
require './database/students_list_db.rb'
require_relative 'gui/main_window'

puts StudentsListDB.get_student(2)