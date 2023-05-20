require_relative "../../support/meta_code"

class DataList
    private_attr_accessor :list
    private_attr_accessor :selected_objects

    def initialize(list:)
        self.list = list
        self.selected_objects = []
    end

    def select(index)
        selected_objects << list[index].id
    end

    def get_id_by_index(index)
        list[index].id
    end

    MESS = "SYSTEM ERROR: method missing"
    protected def get_vars; raise MESS; end
    protected def filter(object); raise MESS; end
    protected def create_data(objects_names); raise MESS; end
    protected def get_real_vars; raise MESS; end
    protected def format_data(objects); end

    def get_names
        filter(get_vars)
    end

    def get_data
        DataTable.new(
                    data: create_data(
                        (0..list.size-1).map { |object_index|
                            get_real_vars
                        }
                    )
                )
    end

    def replace_objects(objects)
        objects = format_data(objects)

        self.list = objects.dup
        EventManager.notify(EventUpdateStudentsTable.new(get_data, get_names))
    end
end