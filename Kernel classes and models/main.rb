require_relative "Student"
require_relative "Student_short"

Student.write_to_txt(".","info2.txt",Student.read_from_txt("info.txt"))
puts Student.read_from_txt("info2.txt")