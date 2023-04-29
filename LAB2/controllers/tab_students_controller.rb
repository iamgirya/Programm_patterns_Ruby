# frozen_string_literal: true

require_relative '../ui/main_screen'
require_relative '../data_base/students_list_db'
require_relative '../models/data_list/data_list_short'
require_relative '../event/event_manager'
require_relative '../event/event_update_students_table'
require_relative '../event/event_update_students_count'
require_relative 'student_input_form_controller'
require_relative 'student_input_form_controller_edit'

class TabStudentsController
  def initialize(view, student_per_page)
    @view = view
    @data_list = DataListStudentShort.new(list: [])
    @student_per_page = student_per_page
    @current_page = 1
  end

  def show_view
    @view.create.show
  end

  def show_modal_add
    controller = StudentInputFormControllerCreate.new(self)
    view = StudentInputForm.new(controller,self)
    controller.set_view(view)
    view.create.show
  end

  def show_modal_edit(selected_row)
    student_num = (@current_page - 1) * @student_per_page + selected_row
    @data_list.select(student_num)
    controller = StudentInputFormControllerEdit.new(self, student_num)
    view = StudentInputForm.new(controller, self)
    controller.set_view(view)
    view.create.show
  end

  def refresh_data
    StudentsListDB.get_students_slice(@current_page, @student_per_page, @data_list)
    EventManager.notify(EventUpdateStudentsCount.new(StudentsListDB.count))
  end

  def get_page
    @current_page
  end

  def next_page(is_left)
    if is_left
      @current_page = [@current_page - 1, 1].max
    else
      @current_page = [@current_page + 1, (@total_count / STUDENTS_PER_PAGE.to_f).ceil].min
    end
    @controller.refresh_data(@current_page)
  end
end