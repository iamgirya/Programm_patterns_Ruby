class DataTable 
    private_attr_accessor :data

    def initialize(data:)
        self.data = data
    end

    def element(row:, column:)
        data[row][column]
    end

    def columns_count
        data[0].size
    end

    def to_2d_array
        data.dup
    end

    def rows_count
        data.size
    end
end