class Student
  @@num_obj = 0
  def initialize(surname, first_name, patronymics, phone_number = nil, telegram  = nil, email = nil, git = nil)
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

  def id
    @id
  end
  def id=(int)
    @id = int
  end

  def surname
    @surname
  end
  def surname=(str)
    @surname = str
  end

  def first_name
    @first_name
  end
  def first_name=(str)
    @first_name = str
  end

  def patronymics
    @patronymics
  end
  def patronymics=(str)
    @patronymics = str
  end

  def phone_number
    @phone_number
  end
  def phone_number=(str)
    @phone_number = str
  end

  def telegram
    @telegram
  end
  def telegram=(str)
    @telegram = str
  end

  def email
    @email
  end
  def email=(str)
    @email = str
  end

  def git
    @git
  end
  def git=(str)
    @git = str
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

student1 = Student.new('Andreev', 'Andrey', 'Andreevich', '+7123456789', 'SolWind', 'abc@mail.com', 'GitName')
student2 = Student.new('Antonov', 'Anton', 'Antonovich', '+7987654321', 'TelegName', 'cba@email.com', 'NewGit')

puts student1.id, student1.surname, student1.first_name, student1.patronymics, student1.phone_number, student1.telegram, student1.email, student1.git
p student2.id, student2.surname, student2.first_name, student2.patronymics, student2.phone_number, student2.telegram, student2.email, student2.git

puts student1
puts student2