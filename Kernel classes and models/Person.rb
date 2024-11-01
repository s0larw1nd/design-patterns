class Person
  attr_reader :id
  def initialize(options = {})
    @id = options[:id] if options[:id]
    @git = options[:git] if options[:git]
  end

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

  def self.validate_options(options = {})
    option_validators = {
      phone_number: method(:is_valid_phone_number?),
      telegram: method(:is_valid_telegram?),
      email: method(:is_valid_email?),
      git: method(:is_valid_git?)
    }

    option_validators.all? {|key, validator| options[key].nil? || validator.call(options[key]) }
  end

  def self.is_valid_connections?(connections = {})
    [connections[:email], connections[:phone], connections[:telegram]].any? { |word| !word.nil? }
  end

  def to_s
    s = ""
    instance_variables.each do |attr_name|
      attr_value = instance_variable_get(attr_name)
      s += "#{attr_name.to_s[1..-1]}: #{attr_value};\n"
    end
    s
  end

  def get_git
    "#{@git}"
  end
end