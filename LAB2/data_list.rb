class DataList 
    private_attr_accessor :list
    private_attr_accessor :selected_objects

    def initialize(list:)
        self.list = list
    end

    def select(index)
        selected_objects << index
    end

    def get_selected_objects
        selected_objects.map { |x| x.id }
    end

    def get_names
        raise "Метод не реализован"
    end

    def get_data
        raise "Метод не реализован"
    end
end