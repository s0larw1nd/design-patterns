class Student
  attr_accessor :surname, :first_name, :patronymics, :phone_number, :telegram, :email, :git

  @@num_obj = 0
  def initialize(surname, first_name, patronymics, options = {})
     @id = @@num_obj
     @surname = surname
     @first_name = first_name
     @patronymics = patronymics
     raise StandardError.new "Неправильный номер телефона" unless options[:phone_number] == nil or Student.check_tel_num(options[:phone_number])
     @phone_number = options[:phone_number]
     @telegram = options[:telegram]
     @email = options[:email]
     @git = options[:git]
     
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

  def self.check_tel_num num
    return /^(\+\d-)?\(?[\d]{3}\)?[\s|-]?[\d]{3}-?[\d]{4}$/.match(num)
  end
end

student1 = Student.new('Andreev', 'Andrey', 'Andreevich', telegram: "Telega", phone_number: '+7-555-123-5645')
student2 = Student.new('Antonov', 'Anton', 'Antonovich', {email: 'cba@email.com', git: 'NewGit', phone_number: '+75551235645'})

puts student1
puts student2