class Students_list
    attr_accessor :list
    def initialize(strategy, list = [])
        raise ArgumentError.new("Ошибка: требуется передать аргумент класса File_strategy") unless strategy.is_a?(File_strategy)
        @strategy = strategy
        @list = list
    end

    def strategy=(strategy)
        raise ArgumentError.new("Ошибка: требуется передать аргумент класса File_strategy") unless strategy.is_a?(File_strategy)
        @strategy = strategy
    end

    def read_from_file(file_path)
        @list = @strategy.read_from_file(file_path)
    end

    def write_to_file(file_path)
        @strategy.write_to_file(@list, file_path)
    end

    def get_student_at(id)
        @list.each do |el|
            if el.id == id && el.is_a?(Student)
                return el
            end
        end

        return nil
    end

    def get_k_n_student_short_list(k: 1, n: 1, data_list: nil)
        selected = @list[n*(k-1)..n*k-1].map { |stud| Student_short.new_from_student(stud) }
        
        if data_list.nil?
            data_list = Data_list.new(selected)
        else
            data_list.list = selected
        end
    end
    
    def sort()
        return Students_list.new(@strategy, @list.sort_by { |student| student.full_name })
    end

    def sort!()
        @list.sort_by! { |student| student.full_name }
    end

    def is_uniq?(stud)
        for st_list in @list
          for var in [:@telegram, :@email, :@phone_number, :@git]
            if !st_list.instance_variable_get(var).nil? && st_list.instance_variable_get(var) == stud.instance_variable_get(var)
              return false
            end
          end
        end
    
        return true
    end

    def add_student(stud)
        raise ArgumentError.new("Ошибка: нарушение уникальности") if !is_uniq?(stud)
        raise ArgumentError.new("Ошибка: требуется передать аргумент класса Student") unless stud.is_a?(Student)

        if !@list.empty?
            temp = @list.max_by{ |student| student.id }
            stud.id = temp.id+1
        else
            stud.id = 0
        end
        @list.append(stud)
    end

    def replace_student(id, stud)
        raise ArgumentError.new("Ошибка: нарушение уникальности") if !is_uniq?(stud)
        raise ArgumentError.new("Ошибка: требуется передать аргумент класса Student") unless stud.is_a?(Student)
    
        @list.each_with_index do |el, idx|
            if el.id == id
                stud.id = id
                @list[idx] = stud
            end
        end
    end

    def delete_student(id)
        @list.select! { |el| el.id != id }
    end

    def get_student_short_count()
        @list.size
    end
end