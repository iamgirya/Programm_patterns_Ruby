# frozen_string_literal: true

require 'glimmer-dsl-libui'
require_relative '../controllers/student_input_form_controller'
require_relative '../models/student/student_abstract'
require 'win32api'

class StudentInputForm
  include Glimmer

  def initialize(controller, existing_student = nil, main_controller)
    @existing_student = existing_student.to_hash unless existing_student.nil?
    @controller = controller
    @entries = {}
    @main_controller = main_controller
  end

  def on_create
    @controller.on_view_created
  end

  def create
    @root_container = window('Универ', 300, 150) {
      resizable false

      vertical_box {
        @student_form = form {
          stretchy false

          fields = [[:last_name, 'Фамилия', false], [:first_name, 'Имя', false], [:paternal_name, 'Отчество', false], [:git, 'Гит', true], [:telegram, 'Телеграм', true], [:email, 'Почта', true], [:phone, 'Телефон', true]]

          fields.each do |field|
            @entries[field[0]] = entry {
              label field[1]
            }
          end
        }

        button('Сохранить') {
          stretchy false

          on_clicked {
            values = @entries.transform_values { |v| v.text.force_encoding("utf-8").strip }
            values.transform_values! { |v| v.empty? ? nil : v}

            @controller.process_fields(values)
            @main_controller.refresh_data
          }
        }
      }
    }
    on_create
    @root_container
  end

  def set_value(field, value)
    return unless @entries.include?(field)

    @entries[field].text = value
  end

  def make_readonly(*fields)
    fields.each do |field|
      @entries[field].read_only = true
    end
  end

  def close
    @root_container.destroy
  end
end