require_relative "Student"
require_relative "Student_short"
require_relative "BinarySearchTree"

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
    students_list.each do |stud|
      file.puts stud.to_s.gsub!("\n", "").gsub!(" ", "")
    end
  end
end

write_to_txt(".","info2.txt",read_from_txt("info.txt"))
puts read_from_txt("info2.txt")

tree = BinarySearchTree.new

student1 = Student.new(surname: 'Иванов', first_name: 'Иван', patronymics: 'Иванович', birth_date: '2001-03-15')
student2 = Student.new(surname: 'Петров', first_name: 'Петр', patronymics: 'Петрович', birth_date: '2000-07-15')
student3 = Student.new(surname: 'Сидоров', first_name: 'Сергей', patronymics: 'Сергеевич', birth_date: '2002-01-10')
student4 = Student.new(surname: 'Кузнецов', first_name: 'Кирилл', patronymics: 'Олегович', birth_date: '2000-03-25')
student5 = Student.new(surname: 'Смирнов', first_name: 'Дмитрий', patronymics: 'Алексеевич', birth_date: '2003-05-30')
student6 = Student.new(surname: 'Попов', first_name: 'Алексей', patronymics: 'Васильевич', birth_date: '2001-10-05')
student7 = Student.new(surname: 'Васильев', first_name: 'Андрей', patronymics: 'Григорьевич', birth_date: '2002-12-12')
student8 = Student.new(surname: 'Морозов', first_name: 'Евгений', patronymics: 'Иванович', birth_date: '1999-08-22')
student9 = Student.new(surname: 'Федоров', first_name: 'Максим', patronymics: 'Игоревич', birth_date: '2003-11-18')
student10 = Student.new(surname: 'Новиков', first_name: 'Владимир', patronymics: 'Борисович', birth_date: '2001-06-17')

tree.insert(student1)
tree.insert(student2)
tree.insert(student3)
tree.insert(student4)
tree.insert(student5)
tree.insert(student6)
tree.insert(student7)
tree.insert(student8)
tree.insert(student9)
tree.insert(student10)

tree.dfs { |elem| puts elem}
tree.bfs { |elem| puts elem}

stud_list = Students_list.new(Students_list_JSON.new())
stud_list.read_from_file("students.json")
stud_list.strategy=Students_list_YAML.new()
stud_list.write_to_file("students.yml")