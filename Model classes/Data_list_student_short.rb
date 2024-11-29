require_relative 'Data_list'

class Data_list_student_short < Data_list
    def get_names
        ['№', 'surname_initials', 'contact', 'git']
    end

    def get_data
        table = []
        
        @list.each_with_index { |el, id| 
            table.append([id, get_names[1..].map{|name| el.instance_variable_get "@#{name}".to_sym}].flatten)
        }

        Data_table.new(table)
    end
end