class Student
  attr_accessor :surname, :first_name, :patronymics, :phone_number, :telegram, :email, :git

  @@num_obj = 0
  def initialize(surname, first_name, patronymics, phone_number: nil, telegram: nil, email: nil, git: nil)
     @id = @@num_obj
     @surname = surname
     @first_name = first_name
     @patronymics = patronymics
     @phone_number = phone_number
     @telegram = telegram
     @email = email
     @git = git
     
     @@num_obj += 1
  end

  def to_s
    s = "id: #{@id}\nФамилия: #{@surname}\nИмя: #{@first_name}\nОтчество: #{@patronymics}\n"
    s = s + "Номер телефона: #{@phone_number}\n" if @phone_number != nil
    s = s + "Телеграм: #{@telegram}\n" if @telegram != nil
    s = s + "Почта: #{@email}\n" if @email != nil
    s = s + "Git: #{@git}" if @git != nil
    s
  end
end

student1 = Student.new('Andreev', 'Andrey', 'Andreevich', telegram: "Telega")
student2 = Student.new('Antonov', 'Anton', 'Antonovich', email: 'cba@email.com', git: 'NewGit', phone_number: '+7987654321')

puts student1
puts student2