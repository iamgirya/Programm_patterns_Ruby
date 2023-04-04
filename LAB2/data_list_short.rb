require_relative './data_list.rb'
require_relative './data_table.rb'

class DataListStudentShort < DataList 

    private_attr_accessor :names  

    def initialize(list:) 
        super(list: list)

        self.names = get_names
    end

    private def select_vars(object)
        object.instance_variables.map { |x| x.to_s[1..-1] }.map { |x| x[1..-1] }
    end

    private def filter(object)
        object.filter { |x| x  != "@id" }
    end

    private def create_data(objects_names)
        (0...objects_names.size).map { |item_index|
            (0...objects_names[item_index].size + 1).map { |name_index|
                if name_index == 0 then item_index else
                    list[item_index].instance_variable_get("@#{objects_names[item_index][name_index - 1]}")
                end
            }
        }
    end

    
end