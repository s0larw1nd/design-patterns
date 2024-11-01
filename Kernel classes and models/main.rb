require_relative "Student"
require_relative "Student_short"

def read_from_txt(file_path)
  raise StandardError.new("Ошибка: Файл не существует") unless File.file?(file_path)
  students_list = []
  File.open(file_path, "r") do |file|
    file.each_line do |line|
      students_list.push(Student.new_from_string(line.chomp))
    end
  end
  students_list
end

def write_to_txt(file_path, file_name, students_list)
  File.open("#{file_path}/#{file_name}", "w") do |file|
    file.puts(students_list)
  end
end

#Student.write_to_txt(".","info2.txt",Student.read_from_txt("info.txt"))
#puts Student.read_from_txt("info2.txt")

student = Student.new('Фамилия', 'Имя', 'Отчество', id:0, email: 'aboba@yand.ry')
puts student
s = Student_short.new_from_student(student)