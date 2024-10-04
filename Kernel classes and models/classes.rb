class Person
  def self.is_valid_name?(name)
    /^[А-яЁё]{2,}$/.match?(name)
  end

  def self.is_valid_telegram?(telegram)
    /^[A-z0-9_]{5,32}$/.match?(telegram)
  end

  def self.is_valid_phone_number?(num)
    /^(\+\d-)?\(?[\d]{3}\)?[\s|-]?[\d]{3}-?[\d]{4}$/.match?(num)
  end

  def self.is_valid_email?(email)
    /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(email)
  end

  def self.is_valid_git?(git)
    /^(([A-z0-9]-)?[A-z0-9]+){4,39}$/.match?(git)
  end

  def self.validate_options(**options)
    option_validators = {
      phone_number: method(:is_valid_phone_number?),
      telegram: method(:is_valid_telegram?),
      email: method(:is_valid_email?),
      git: method(:is_valid_git?)
    }

    option_validators.each do |key, validator|
      raise StandardError.new("Неправильный #{key.capitalize}") unless options[key].nil? || validator.call(options[key])
    end
  end

  def self.is_valid_connections?(**connections)
    [connections[:email], connections[:phone], connections[:telegram]].any? { |word| !word.nil? }
  end
end

class Student < Person
  attr_reader :surname, :first_name, :patronymics, :phone_number, :telegram, :email
  attr_accessor :id

  @@num_obj = 0
  def initialize(surname, first_name, patronymics, **options)
     @id = @@num_obj

     Student.validate_full_name(surname, first_name, patronymics)
     @surname = surname 
     @first_name = first_name
     @patronymics = patronymics
  
     Student.validate_options(**options)
     @phone_number = options[:phone_number]
     @telegram = options[:telegram]
     @email = options[:email]
     @git = options[:git]
 
     @@num_obj += 1
  end

  def self.validate_full_name(surname, first_name, patronymics)
    if ![surname, first_name, patronymics].all? { |word| Student.is_valid_name?(word) }
      raise StandardError.new("Неправильное ФИО")
    end
  end

  def self.validate_git_and_connections
    raise StandardError.new("Ошибка: требуется задать Git и хотя бы один контакт") unless Student.is_valid_git?(@git) && Student.is_valid_connections?(email: @email, phone: @phone_number, telegram: @telegram)
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
    new(result["surname"], result["first_name"], result["patronymics"], **result_opt.transform_keys(&:to_sym))
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

  def set_contacts(**options)
    Student.validate_options(**options)

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
    new(id, student.getInfo)
  end
  
  def initialize(id, string)
    raise StandardError.new("Ошибка: требуется строка") unless string.is_a?(String)
    @id = id
    pairs = string.split(';')
    raise StandardError.new("Ошибка: некорректная строка") if pairs.count < 3

    raise StandardError.new("Неправильное ФИО") unless Student_short.is_valid_name?(pairs[0])
    options = { "git" => pairs[1], pairs[2].split(':')[0] => pairs[2].split(':')[1] }.transform_keys(&:to_sym)
    Student_short.validate_options(**options)
    raise StandardError.new("Требуется задать контакт") unless Student_short.is_valid_connections?(**options)

    @name = pairs[0]
    @git = pairs[1]
    @contact = pairs[2].split(':')[1]
  end
end