require_relative './data_list.rb'
require_relative './data_table.rb'

class DataListStudentShort < DataList 
    def get_names
        return list[0].instance_variables.map { |x| x.to_s }.map { |x| x[1..-1] }.filter { |x| x  != "@id" }
    end

    def get_data 
        @names = get_names

        puts @names
        return DataTable.new(data: (0...list.size).map { |item_index|
            (0...@names.size + 1).map { |name_index|
                if name_index == 0 then item_index else
                    list[item_index].instance_variable_get("@#{@names[name_index - 1]}")
                end
            }
        })
    end
end