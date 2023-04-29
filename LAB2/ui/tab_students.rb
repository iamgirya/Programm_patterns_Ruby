# frozen_string_literal: true
require 'glimmer-dsl-libui'
require_relative '../controllers/tab_students_controller'
require_relative '../event/event_manager'
require_relative '../event/event_update_students_table'
require_relative '../event/event_update_students_count'
require_relative '../ui/student_input_form'

class TabStudents
  include Glimmer

  STUDENTS_PER_PAGE = 20

  def initialize
    @controller = TabStudentsController.new(self, STUDENTS_PER_PAGE)
    @total_count = 0
  end

  def on_create
    EventManager.subscribe(self, EventUpdateStudentsTable)
    EventManager.subscribe(self, EventUpdateStudentsCount)
    @controller.refresh_data
  end

  def on_event(event)
    case event
    when EventUpdateStudentsTable
      @table.model_array = event.new_table.to_2d_array
    when EventUpdateStudentsCount
      @total_count = event.new_count
      @page_label.text = "#{@controller.get_page} / #{(@total_count / STUDENTS_PER_PAGE.to_f).ceil}"
    end
  end

  def create
    root_container = horizontal_box {
      # Секция 1
      vertical_box {
        stretchy false

        form {
          stretchy false

          @filter_last_name_initials = entry {
            label 'Фамилия И. О.'
          }

          @filters = {}
          fields = [[:git, 'Гит'], [:email, 'Почта'], [:phone, 'Телефон'], [:telegram, 'Телеграм']]

          fields.each do |field|
            @filters[field[0]] = {}

            @filters[field[0]][:combobox] = combobox {
              label "#{field[1]} имеется?"
              items ['Не важно', 'Есть', 'Нет']
              selected 0

              on_selected do
                if @filters[field[0]][:combobox].selected == 1
                  @filters[field[0]][:entry].read_only = false
                else
                  @filters[field[0]][:entry].text = ''
                  @filters[field[0]][:entry].read_only = true
                end
              end
            }

            @filters[field[0]][:entry] = entry {
              label field[1]
              read_only true
            }
          end
        }
      }

      # Секция 2
      vertical_box {
        @table = refined_table(
          table_editable: false,
          table_columns: {
            '#' => :text,
            'Фамилия И. О' => :text,
            'Гит' => :text,
            'Контакт' => :text
          },
          per_page: STUDENTS_PER_PAGE
        )

        @pages = horizontal_box {
          stretchy false

          button("<") {
            stretchy true

            on_clicked do
              @controller.next_page(true)
            end

          }
          @page_label = label("...") { stretchy false }
          button(">") {
            stretchy true

            on_clicked do
              @controller.next_page(false )
            end
          }
        }
      }

      # Секция 3
      vertical_box {
        stretchy false

        button('Добавить') {
          stretchy false

          on_clicked {
            @controller.show_modal_add
          }
        }
        button('Изменить') {
          stretchy false

          on_clicked {
            @controller.show_modal_edit(@table.selection) unless @table.selection.nil?
          }
        }
        button('Удалить') { stretchy false }
        button('Обновить') {
          stretchy false

          on_clicked {
            @controller.refresh_data
          }
        }
      }
    }
    on_create
    root_container
  end
end