require_relative 'Data_list'

class Data_list_student_short < Data_list
    private
    def get_names_list
        ['№', 'surname_initials', 'contact', 'git']
    end

    def get_table
        table = []

        @list.each_with_index { |el, id| 
            table.append([id, get_names[1..].map{|name| el.instance_variable_get "@#{name}".to_sym}].flatten)
        }

        table
    end
end