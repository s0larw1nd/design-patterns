require_relative "Person"

class Student_short < Person
  def self.new_from_student(student)
    new(student.id, student.getInfo)
  end
  
  def initialize(id, string)
    raise ArgumentError.new("Ошибка: требуется строка") unless string.is_a?(String)
    pairs = string.split(';')
    raise ArgumentError.new("Ошибка: некорректная строка") if pairs.count < 3

    raise ArgumentError.new("Неправильное ФИО") unless Student_short.is_valid_name?(pairs[0])
    options = { "git" => pairs[1], pairs[2].split(':')[0] => pairs[2].split(':')[1] }.transform_keys(&:to_sym)
    raise ArgumentError.new("Некорректный контакт") unless Student_short.validate_options(options)
    raise ArgumentError.new("Требуется задать контакт") unless Student_short.is_valid_connections?(options)

    super(id: id, git: pairs[1])
    @short_name = pairs[0]
    @contact = pairs[2].split(':')[1]
  end

  def get_full_name
    @short_name
  end
end