require_relative './data_list.rb'
require_relative './data_table.rb'
require_relative '../student/student_short.rb'

class DataListStudentShort < DataList

    private_attr_accessor :names  

    def initialize(list:) 
        super(list: list)

        self.names = get_names
    end

    private def get_vars
        ["ID","ФИО","Git","Контакт"]
    end

    private def get_real_vars
        ["fio","git","contact"]
    end

    private def filter(object)
        object.filter { |x| x  != "ID" }
    end

    private def format_data(objects)
        if objects[0].is_a?(Student)
            objects = objects.map { |x| StudentShort.from_student(x)}
        end
        objects
    end

    private def create_data(objects_names)
        (0...objects_names.size).map { |item_index|
            (0...objects_names[item_index].size + 1).map { |name_index|
                if name_index == 0 then item_index else
                   tmp = list[item_index].instance_variable_get("@#{objects_names[item_index][name_index - 1]}")
                   tmp
                end
            }
        }
    end

    
end