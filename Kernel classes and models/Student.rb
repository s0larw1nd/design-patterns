require_relative "Person"

class Student < Person
  attr_reader :surname, :first_name, :patronymics, :telegram, :email, :phone_number

  def initialize(surname, first_name, patronymics, options = {})
     super(id: options[:id], git: options[:git])

     raise StandardError.new("Ошибка: некорректное ФИО") unless Student.validate_full_name(surname, first_name, patronymics)

     self.instance_variable_set(:@surname, surname)
     self.instance_variable_set(:@first_name, first_name)
     self.instance_variable_set(:@patronymics, patronymics)

     set_contacts(phone_number: options[:phone_number], telegram: options[:telegram], email: options[:email]) if Student.validate_options(options)
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

  def getInfo
    info = get_full_name+";"+get_git+";"+get_contact
  end

  def get_full_name
    "#{@surname}#{@first_name[0]}#{@patronymics[0]}"
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

  def set_name(surname, first_name, patronymics)
    raise StandardError.new("Ошибка: некорректное ФИО") unless Student.validate_full_name(surname, first_name, patronymics)

    self.instance_variable_set(:@surname, surname)
    self.instance_variable_set(:@first_name, first_name)
    self.instance_variable_set(:@patronymics, patronymics)
  end

  def set_contacts(options = {})
    raise StandardError.new("Ошибка: некорректные контакты") unless Student.validate_options(options)

    self.instance_variable_set(:@phone_number, options[:phone_number]) unless options[:phone_number].nil?
    self.instance_variable_set(:@telegram, options[:telegram]) unless options[:telegram].nil?
    self.instance_variable_set(:@email, options[:email]) unless options[:email].nil?
  end

  private
  def self.validate_full_name(surname, first_name, patronymics)
    return [surname, first_name, patronymics].all? { |word| Student.is_valid_name?(word) }
  end

  def validate_git
    Student.is_valid_git?(@git)
  end

  def validate_connections
    Student.is_valid_connections?(email: @email, phone: @phone_number, telegram: @telegram)
  end
end
