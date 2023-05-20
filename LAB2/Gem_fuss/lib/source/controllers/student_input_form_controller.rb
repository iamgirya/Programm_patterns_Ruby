# frozen_string_literal: true

require 'win32api'

class StudentInputFormControllerCreate
  def initialize(parent_controller)
    @parent_controller = parent_controller
  end

  def set_view(view)
    @view = view
  end

  def on_view_created
  end

  def process_fields(fields)
    begin
      last_name = fields.delete(:last_name)
      first_name = fields.delete(:first_name)
      paternal_name = fields.delete(:paternal_name)

      return if last_name.nil? || first_name.nil? || paternal_name.nil?

      student = Student.new(last_name, first_name, paternal_name, **fields)

      StudentsListDB.add_student(student)

      @view.close
    rescue ArgumentError => e
      api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
      api.call(0, e.message, 'Error', 0)
    end
  end

  private

  def on_db_conn_error
    api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
    api.call(0, "No connection to DB", "Error", 0)
    @view.close
  end
end