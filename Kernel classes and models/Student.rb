require_relative "Person"
require 'date'

class Student < Person
  include Comparable
  attr_reader :surname, :first_name, :patronymics, :telegram, :email, :phone_number, :birth_date

  def initialize(id: nil, surname: nil, first_name: nil, patronymics: nil, telegram: nil, email: nil, phone_number: nil, birth_date: nil, git: nil)
     super(id: id.to_i, git: git)
     set_name(surname: surname, first_name: first_name, patronymics: patronymics)
     set_contacts(phone_number: phone_number, telegram: telegram, email: email)
     self.birth_date = birth_date unless birth_date.nil?
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
    full_name+";"+(@git||"")+";"+get_contact
  end

  def set_name(surname: @surname, first_name: @first_name, patronymics: @patronymics)
    raise ArgumentError.new("Ошибка: некорректное ФИО") unless Student.validate_full_name(surname, first_name, patronymics)

    instance_variable_set(:@surname, surname)
    instance_variable_set(:@first_name, first_name)
    instance_variable_set(:@patronymics, patronymics)
  end

  def set_contacts(phone_number: nil, telegram: nil, email: nil)
    raise ArgumentError.new("Ошибка: некорректные контакты") unless Student.validate_options(phone_number: phone_number, telegram: telegram, email: email)

    instance_variable_set(:@phone_number, phone_number) unless phone_number.nil?
    instance_variable_set(:@telegram, telegram) unless telegram.nil?
    instance_variable_set(:@email, email) unless email.nil?
  end

  def birth_date=(date)
    @birth_date = Date.parse(date)
  end

  def id=(id)
    raise ArgumentError.new("Ошибка: требуется задать id") unless id

    instance_variable_set(:@id, id)
  end

  def git=(git)
    raise ArgumentError.new("Ошибка: некорректный Git") unless Person.validate_options(git: git)

    instance_variable_set(:@git, git)
  end

  def <=>(other)
    self.birth_date <=> other.birth_date
  end

  private
  def self.validate_full_name(surname, first_name, patronymics)
    return [surname, first_name, patronymics].all? { |word| Student.is_valid_name?(word) }
  end
end