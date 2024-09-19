class Student
  attr_accessor :surname, :first_name, :patronymics, :phone_number, :telegram, :email, :git

  @@num_obj = 0
  def initialize(surname, first_name, patronymics, options = {})
     @id = @@num_obj
     raise StandardError.new "Неправильное ФИО" unless [surname, first_name, patronymics].all? { |word| Student.check_name(word) }
     @surname = surname 
     @first_name = first_name
     @patronymics = patronymics
  
     raise StandardError.new("Неправильный номер телефона") unless options[:phone_number].nil? || Student.check_tel_num(options[:phone_number])
     raise StandardError.new("Неправильный Telegram") unless options[:telegram].nil? || Student.check_telegram(options[:telegram])
     raise StandardError.new("Неправильный E-mail") unless options[:email].nil? || Student.check_email(options[:email])
     raise StandardError.new("Неправильный Git") unless options[:git].nil? || Student.check_git(options[:git])
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
    /^(\+\d-)?\(?[\d]{3}\)?[\s|-]?[\d]{3}-?[\d]{4}$/.match(num)
  end

  def self.check_name(name)
    /^[А-я]{2,}$/.match?(name)
  end

  def self.check_telegram(telegram)
    /^[A-z0-9_]{5,32}$/.match?(telegram)
  end

  def self.check_email(email)
    /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(email)
  end

  def self.check_git(git)
    /^(([A-z0-9]-)?[A-z0-9]+){4,39}$/.match?(git)
  end
end

student1 = Student.new('Андреев', 'Андрей', 'Андреевич', telegram: "Telega")
student2 = Student.new('Антонов', 'Антон', 'Антонович', {email: 'cba@email.com', git: 'NewGit', phone_number: '+7-555-123-5645'})

puts student1
puts student2