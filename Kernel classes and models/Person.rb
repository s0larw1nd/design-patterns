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