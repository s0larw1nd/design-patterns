require_relative "Person"

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