require "./Data_list/Students_list.rb"
require "./Data_list/Data_list_student_short.rb"

class StudentListController
  def initialize(view)
    @view = view

    @students_list = Students_list.new(Students_list_YAML.new())
    @students_list.read_from_file("students.yml")
    @data_list = Data_list_student_short.new([])
    @data_list.add_observer(@view)
  end

  def refresh_data
    @data = @students_list.get_k_n_student_short_list(k: @view.current_page, n: @view.items_per_page)
    @data_list.count = @students_list.get_student_short_count
    @data_list.notify(@data)
  end

  def sort_table_by_column(col_idx)
    if col_idx == 1
      @students_list.sort_by_full_name!
    end
    refresh_data
  end

  def add_entry
    puts "Создание записи"
  end

  def edit_entry(row_idx)
    puts "Изменение строки с номером: #{row_idx-1}"
  end

  def delete_entries(row_idx)
    puts "Удаление строк с номерами #{row_idx.map { |i| i - 1 }}"
  end
end