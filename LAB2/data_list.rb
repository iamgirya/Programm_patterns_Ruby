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

    MESS = "SYSTEM ERROR: method missing"
    protected def select_vars(object); raise MESS; end
    protected def filter(object); raise MESS; end
    protected def create_data(object); raise MESS; end
    
    def get_names(object)
        filter(select_vars(object))
    end

    def get_data(object) 
        return DataTable.new(data: create_data(get_names(object)))
    end
end