require_relative "../Data_table/Data_table.rb"

class Data_list
    attr_writer :count
    def initialize(list = [])
        @list = list
        @count = 0
        @selected = []
        @observers = []
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
    
    def notify
        return if @observers.nil?
        @observers.each do |observer|
            observer.set_table_params(get_names, @count)
            observer.set_table_data(get_data)
        end
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

    def add_observer(observer)
        @observers.append(observer)
    end
    
    private
    def get_names_list
    end

    def get_table
    end
end