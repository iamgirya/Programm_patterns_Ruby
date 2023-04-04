class DataTable 
    private_attr_accessor :data

    def initialize(data:)
        self.data = data
    end

    def element(row:, column:)
        data[row][column]
    end

    def columnsCount 
        data[0].size
    end

    def rowsCount
        data.size
    end
end