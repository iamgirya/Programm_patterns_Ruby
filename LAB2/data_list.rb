require_relative "./meta_code.rb"

class DataList
    attr_accessor :list
    private_attr_accessor :selected_objects

    def initialize(list:)
        self.list = list
        self.selected_objects = []
    end

    def select(index)
        selected_objects << index
    end

    def get_selected_objects
        list.filter { |x| selected_objects.include?(x.id) }
    end

    MESS = "SYSTEM ERROR: method missing"
    protected def select_vars(object); raise MESS; end
    protected def filter(object); raise MESS; end
    protected def create_data(objects_names); raise MESS; end

    def get_names
        filter(select_vars(list[0]))
    end

    def get_data
        DataTable.new(
                    data: create_data(
                        (0..list.size).map { |object_index|
                            get_names
                        }
                    )
                )
    end
end