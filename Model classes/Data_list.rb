require_relative "Data_table"

class Data_list
    def initialize(list = [])
        @list = list
        @selected = []
    end

    def select(number)
        @selected.append(@list[number])
    end

    def get_selected()
        ret = []
        @selected.each do |id| ret.append(@list[id]) end
        @selected.clear
        ret
    end

    def get_names()
        get_names_list
    end

    def get_data()
        table = get_table
        Data_table.new(table)
    end

    def list=(new_list)
        @list = new_list
    end
    
    private
    def get_names_list
    end

    def get_table
    end
end