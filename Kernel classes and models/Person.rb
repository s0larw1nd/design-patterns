class Person
  attr_reader :id, :git
  def initialize(id: nil, git: nil)
    @id = id if id
    raise ArgumentError.new("Ошибка: некорректный Git") unless Person.validate_options(git: git)
    @git = git if git
  end

  def contact
    ['contact', 'telegram', 'email', 'phone_number'].each do |cont|
      return "#{cont}:" + instance_variable_get("@#{cont}") unless instance_variable_get("@#{cont}").nil?
    end
    ""
  end

  def full_name
    return @surname_initials if @surname_initials
    "#{@surname}#{@first_name[0]}#{@patronymics[0]}"
  end

  def to_s
    s = ""
    instance_variables.each do |attr_name|
      attr_value = instance_variable_get(attr_name)
      s += "#{attr_name.to_s[1..-1]}: #{attr_value};\n"
    end
    s
  end

  def to_hash
    hash = {}
    instance_variables.each do |attr_name|
      attr_value = instance_variable_get(attr_name)
      hash[attr_name.to_s.gsub("@","")] = attr_value.to_s
    end
    hash
  end

  def has_connection?
    [@email, @phone, @telegram, @contact].any? { |cont| !cont.nil? }
  end

  def has_git?
    !@git.nil?
  end
  
  def has_connection_and_git?
    return has_connection? && has_git?
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
end