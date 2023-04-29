# frozen_string_literal: true

require_relative '../ui/main_screen'
require_relative '../data_base/students_list_db'
require_relative '../models/data_list/data_list_short'
require_relative '../event/event_manager'
require_relative '../event/event_update_students_table'
require_relative '../event/event_update_students_count'

class TabStudentsController
  def initialize(view)
    @view = view
    @data_list = DataListStudentShort.new(list: [])
  end

  def show_view
    @view.create.show
  end

  def show_modal_add
    controller = StudentInputFormControllerCreate.new(self)
    view = StudentInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  def show_modal_edit(current_page, selected_row)

  end

  def refresh_data(page, per_page)
    StudentsListDB.get_students_slice(page, per_page, @data_list)
    EventManager.notify(EventUpdateStudentsCount.new(StudentsListDB.count))
  end
end