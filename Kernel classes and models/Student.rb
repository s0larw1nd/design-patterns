require_relative "Person"

class Student < Person
  attr_reader :surname, :first_name, :patronymics, :telegram, :email, :phone_number

  def initialize(id: nil, surname: nil, first_name: nil, patronymics: nil, telegram: nil, email: nil, phone_number: nil, git: nil)
     super(id: id, git: git)
     set_name(surname: surname, first_name: first_name, patronymics: patronymics)
     set_contacts(phone_number: phone_number, telegram: telegram, email: email)
  end

  def self.new_from_string(string)
    raise ArgumentError.new("Ошибка: требуется строка") unless string.is_a?(String)
    result = {}
    pairs = string.split(';')
    raise ArgumentError.new("Ошибка: некорректная строка") unless pairs.length>=3
    
    pairs.each do |pair|
      key, value = pair.split(':')
      value = value[1..-2] if value.include? "'"
      result[key] = value
    end

    result_opt = result.reject{ |key, value| key == "surname" || key == "first_name" || key == "patronymics" }
    new(surname: result["surname"], first_name: result["first_name"], patronymics: result["patronymics"], **result_opt.transform_keys(&:to_sym))
  end

  def getInfo
    info = get_full_name+";"+get_git+";"+get_contact
  end

  def set_name(surname: @surname, first_name: @first_name, patronymics: @patronymics)
    raise ArgumentError.new("Ошибка: некорректное ФИО") unless Student.validate_full_name(surname, first_name, patronymics)

    self.instance_variable_set(:@surname, surname)
    self.instance_variable_set(:@first_name, first_name)
    self.instance_variable_set(:@patronymics, patronymics)
  end

  def set_contacts(phone_number: nil, telegram: nil, email: nil)
    raise ArgumentError.new("Ошибка: некорректные контакты") unless Student.validate_options(phone_number: phone_number, telegram: telegram, email: email)

    self.instance_variable_set(:@phone_number, phone_number) unless phone_number.nil?
    self.instance_variable_set(:@telegram, telegram) unless telegram.nil?
    self.instance_variable_set(:@email, email) unless email.nil?
  end

  private
  def self.validate_full_name(surname, first_name, patronymics)
    return [surname, first_name, patronymics].all? { |word| Student.is_valid_name?(word) }
  end
end