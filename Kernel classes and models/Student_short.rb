require_relative "Person"

class Student_short < Person
  def self.new_from_student(student)
    new(student.id, student.getInfo)
  end
  
  def initialize(id, string)
    raise ArgumentError.new("Ошибка: требуется строка") unless string.is_a?(String)
    pairs = string.split(';')
    raise ArgumentError.new("Ошибка: некорректная строка") if pairs.count == 0

    raise ArgumentError.new("Неправильное ФИО") unless Student_short.is_valid_name?(pairs[0])
    options = {}
    options[:git] = pairs[1] if pairs[1] != ""
    options[pairs[2].split(':')[0].to_sym] = pairs[2].split(':')[1] if pairs[2]
    raise ArgumentError.new("Некорректный git/контакт") unless Student_short.validate_options(options)

    super(id: id, git: options[:git])
    instance_variable_set(:@short_name, pairs[0])
    instance_variable_set(:@contact, options[:email] || options[:phone_number] || options[:telegram]) if options[:email] || options[:phone_number] || options[:telegram]
  end
end
