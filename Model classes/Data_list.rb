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
        raise NotImplementedError.new('Метод не имплементирован для класса')
    end

    def get_data()
        raise NotImplementedError.new('Метод не имплементирован для класса')
    end
end