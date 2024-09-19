class Student
  attr_reader :phone_number, :telegram, :email
  attr_accessor :id, :surname, :first_name, :patronymics, :git

  @@num_obj = 0
  def initialize(surname, first_name, patronymics, options = {})
     @id = @@num_obj
     raise StandardError.new("Неправильное ФИО") unless [surname, first_name, patronymics].all? { |word| Student.is_valid_name?(word) }
     @surname = surname 
     @first_name = first_name
     @patronymics = patronymics
  
     raise StandardError.new("Неправильный номер телефона") unless options[:phone_number].nil? || Student.is_valid_tel_num?(options[:phone_number])
     raise StandardError.new("Неправильный Telegram") unless options[:telegram].nil? || Student.is_valid_telegram?(options[:telegram])
     raise StandardError.new("Неправильный E-mail") unless options[:email].nil? || Student.is_valid_email?(options[:email])
     raise StandardError.new("Неправильный Git") unless options[:git].nil? || Student.is_valid_git?(options[:git])
     @phone_number = options[:phone_number]
     @telegram = options[:telegram]
     @email = options[:email]
     @git = options[:git]

     raise StandardError.new("Ошибка: требуется задать Git и хотя бы один контакт") unless Student.is_valid_git?(@git) && Student.is_valid_connections?(@email,@phone_number,@telegram)
     
     @@num_obj += 1
  end

  def to_s
    s = "id: #{@id}\nФамилия: #{@surname}\nИмя: #{@first_name}\nОтчество: #{@patronymics}\n"
    s = s + "Номер телефона: #{@phone_number}\n" unless @phone_number.nil?
    s = s + "Телеграм: #{@telegram}\n" unless @telegram.nil?
    s = s + "Почта: #{@email}\n" unless @email.nil?
    s = s + "Git: #{@git}" unless @git.nil?
    s
  end

  def self.is_valid_tel_num?(num)
    /^(\+\d-)?\(?[\d]{3}\)?[\s|-]?[\d]{3}-?[\d]{4}$/.match?(num)
  end

  def self.is_valid_name?(name)
    /^[А-я]{2,}$/.match?(name)
  end

  def self.is_valid_telegram?(telegram)
    /^[A-z0-9_]{5,32}$/.match?(telegram)
  end

  def self.is_valid_email?(email)
    /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(email)
  end

  def self.is_valid_git?(git)
    /^(([A-z0-9]-)?[A-z0-9]+){4,39}$/.match?(git)
  end

  def self.is_valid_connections?(email, phone, telegram)
    [email, phone, telegram].any? { |word| !word.nil? }
  end

  def set_contacts(options = {})
    raise StandardError.new("Неправильный номер телефона") unless options[:phone_number].nil? || Student.is_valid_tel_num?(options[:phone_number])
    raise StandardError.new("Неправильный Telegram") unless options[:telegram].nil? || Student.is_valid_telegram?(options[:telegram])
    raise StandardError.new("Неправильный E-mail") unless options[:email].nil? || Student.is_valid_email?(options[:email])

    @phone_number = options[:phone_number] unless options[:phone_number].nil?
    @telegram = options[:telegram] unless options[:telegram].nil?
    @email = options[:email] unless options[:email].nil?
  end
end

student1 = Student.new('Андреев', 'Андрей', 'Андреевич', telegram: "Telega")
student2 = Student.new('Антонов', 'Антон', 'Антонович', {email: 'cba@email.com', git: 'NewGit', phone_number: '+7-555-123-5645'})

puts student1
puts student2