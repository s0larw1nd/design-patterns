class Data_table
    def initialize(table = [])
        @table = table
    end

    def at(row, column)
        @table[row][column]
    end

    def rows()
        @table.length
    end

    def columns()
        if rows() > 0
            return @table[0].length
        end
        return 0
    end
end