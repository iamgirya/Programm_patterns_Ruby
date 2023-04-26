# frozen_string_literal: true

require '../ui/main_screen'
require './LabStudents/repositories/student_repository'

class TabStudentsController
  def initialize(view)
    @student_rep = StudentRepository.new(DBSourceAdapter.new)
    @view = view
  end

  def show_view
    @view.create.show
  end

  def refresh_data(page, per_page)
    @data_list = @student_rep.paginated_short_students(page, per_page)
  end
end