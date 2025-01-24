require_relative '../Student.rb'
require_relative 'DB_connection'

class Students_list_DB
  @connection = DB_connection.instance

  def initialize(list = [])
    @list = list
  end

  def select_from_DB
    list = @connection.select()
    list.each_with_index { |elem, idx|
      stud = Student.new(**elem)
      stud.id = idx
      @list << stud
    }
  end

  def get_student_at(id)
    @list.each do |el|
      if el.id == id && el.is_a?(Student)
        return el
      end
    end
  end

  def get_k_n_student_short_list(k: 1, n: 1, data_list: nil)
    selected = @list[n*(k-1)..n*k-1].map { |stud| Student_short.new_from_student(stud) }
    
    if data_list.nil?
      data_list = Data_list.new(selected)
    else
      data_list.list = selected
    end
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
      stud.id = 1
    end
    @list.append(stud)
  end

  def replace_student(id, stud)
    raise ArgumentError.new("Ошибка: требуется передать аргумент класса Student") unless stud.is_a?(Student)
    raise ArgumentError.new("Ошибка: нарушение уникальности") if !is_uniq?(stud)

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

  def count()
    @list.count
  end
end