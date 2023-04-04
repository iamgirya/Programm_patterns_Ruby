require_relative './data_list.rb'
require_relative './data_table.rb'

class DataListStudentShort < DataList 

    private def select_vars(object)
        object.instance_variables.map { |x| x.to_s[1..-1] }.map { |x| x[1..-1] }
    end

    private def filter(object)
        object.filter { |x| x  != "@id" }
    end

    private def create_data(object)
        (0...list.size).map { |item_index|
            (0...object.size + 1).map { |name_index|
                if name_index == 0 then item_index else
                    list[item_index].instance_variable_get("@#{object[name_index - 1]}")
                end
            }
        }
    end

    
end