class Person
  def self.is_valid_name?(name)
    /^[А-яЁё]{2,}$/.match?(name)
  end

  def self.is_valid_telegram?(telegram)
    /^[A-z0-9_]{5,32}$/.match?(telegram)
  end

  def self.is_valid_tel_num?(num)
    /^(\+\d-)?\(?[\d]{3}\)?[\s|-]?[\d]{3}-?[\d]{4}$/.match?(num)
  end

  def self.is_valid_email?(email)
    /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(email)
  end

  def self.is_valid_git?(git)
    /^(([A-z0-9]-)?[A-z0-9]+){4,39}$/.match?(git)
  end
end

class Student < Person
  attr_reader :surname, :first_name, :patronymics, :phone_number, :telegram, :email, :git
  attr_accessor :id

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

  def self.new_from_string(string)
    raise StandardError.new("Ошибка: требуется строка") unless string.is_a?(String)
    result = {}
    pairs = string.split(';')
    raise StandardError.new("Ошибка: некорректная строка") unless pairs.length>=5
    
    pairs.each do |pair|
      key, value = pair.split(':')
      value = value[1..-2] if value.include? "'"
      result[key] = value
    end

    result_opt = result.reject{ |key, value| key == "surname" || key == "first_name" || key == "patronymics" }
    new(result["surname"], result["first_name"], result["patronymics"], result_opt.transform_keys(&:to_sym))
  end

  def to_s
    s = "id:#{@id};surname:#{@surname};first_name:#{@first_name};patronymics:#{@patronymics};git:#{@git}"
    s += ";phone_number:#{@phone_number}" unless @phone_number.nil?
    s += ";telegram:#{@telegram}" unless @telegram.nil?
    s += ";email:#{@email}" unless @email.nil?
    s
  end

  def getInfo
    info = self.get_full_name+";"+self.get_git+";"+self.get_contact
  end

  def get_full_name
    "#{@surname}#{@first_name[0]}#{@patronymics[0]}"
  end

  def get_git
    "#{@git}"
  end

  def get_contact
    if @telegram != nil
      "telegram:#{@telegram}"
    elsif @email != nil
      "email:#{@email}"
    else
      "phone_number:#{@phone_number}"
    end
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

  def self.read_from_txt(file_path)
    raise StandardError.new("Ошибка: Файл не существует") unless File.file?(file_path)
    students_list = []
    File.open(file_path, "r") do |file|
      file.each_line do |line|
        students_list.push(Student.new_from_string(line.chomp))
      end
    end
    students_list
  end

  def self.write_to_txt(file_path, file_name, students_list)
    File.open("#{file_path}/#{file_name}", "w") do |file|
      file.puts(students_list)
    end
  end
end

class Student_short < Person
  attr_reader :id, :name, :git, :contact

  def self.new_from_student(student)
    id = student.id
    new(id,student.getInfo)
  end
  
  def initialize(id, string)
    raise StandardError.new("Ошибка: требуется строка") unless string.is_a?(String)
    @id = id
    pairs = string.split(';')
    raise StandardError.new("Ошибка: некорректная строка") if pairs.count < 3

    raise StandardError.new("Неправильное ФИО") unless Student_short.is_valid_name?(pairs[0])
    raise StandardError.new("Неправильный Git") unless Student_short.is_valid_git?(pairs[1])

    case pairs[2].split(':')[0]
    when "phone_number"
      raise StandardError.new("Неправильный номер телефона") unless Student_short.is_valid_tel_num?(pairs[2].split(':')[1])
    when "telegram"
      raise StandardError.new("Неправильный Telegram") unless Student_short.is_valid_telegram?(pairs[2].split(':')[1])
    when "email"
      raise StandardError.new("Неправильный E-mail") unless Student_short.is_valid_email?(pairs[2].split(':')[1])
    else
      raise StandardError.new("Ошибка: требуется задать контакт")
    end

    @name = pairs[0]
    @git = pairs[1]
    @contact = pairs[2].split(':')[1]
  end
end

Student.write_to_txt("D:/ruby","info2.txt",Student.read_from_txt("info.txt"))
puts Student.read_from_txt("info2.txt")