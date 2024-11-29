require 'json'

class Students_list_JSON
    def initialize(list = [])
        @list = list
    end

    def read_from_file(file_path)
        raise StandardError.new("Ошибка: Файл не существует") unless File.file?(file_path)

        file = File.read(file_path)
        data_hash = JSON.parse(file)
        res = []
        data_hash.each_with_index do |el, id|
            el['id'] = id
            el = el.transform_keys(&:to_sym)
            res << Student.new(**el)
        end

        @list = res
    end

    def write_to_file(file_path)
        res = []
        @list.each do |el|
            el_hash = {}
            el.instance_variables.each do |attr_name|
                el_hash[attr_name.to_s.gsub("@","")] = el.instance_variable_get(attr_name)
            end
            res << el_hash
        end
        File.write(file_path, JSON.dump(res))
    end

    def get_at(id)
        @list.each do |el|
            if el.id == id
                return el
            end
        end
    end

    def get_k_n_student_short_list(k: 2, n: 20, data_list: nil)
        selected = @list[n*(k-1)..n*k-1].map { |stud| Student_short.new_from_student(stud) }
        
        if data_list.nil?
            data_list = Data_list.new(selected)
        else
            data_list.list = selected
        end
    end
    
    def sort()
        @list.sort_by { |student| student.surname + student.first_name[0] + student.patronymics[0] }
    end

    def sort!()
        @list.sort_by! { |student| student.surname + student.first_name[0] + student.patronymics[0] }
    end

    def add_student(stud)
        raise ArgumentError.new("Ошибка: требуется передать аргумент класса Student") unless stud.is_a?(Student)

        stud.id = @list.max_by{ |student| student.id }.id+1
        @list.append(stud)
    end

    def replace_student(id, stud)
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
        @list.count { |el| el.is_a?(Student_short) }
    end
end