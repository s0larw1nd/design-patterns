class Student
  @@num_obj = 0
  def initialize(surname, first_name, patronymics, phone_number = nil, telegram  = nil, email = nil, git = nil)
     @id = @@num_obj
     @surname = surname
     @first_name = first_name
     @patronymics = patronymics
     @phone_number = phone_number
     @telegram = telegram
     @email = email
     @git = git
     
     @@num_obj += 1
  end

  def id
    @id
  end
  def id=(int)
    @id = int
  end

  def surname
    @surname
  end
  def surname=(str)
    @surname = str
  end

  def first_name
    @first_name
  end
  def first_name=(str)
    @first_name = str
  end

  def patronymics
    @patronymics
  end
  def patronymics=(str)
    @patronymics = str
  end

  def phone_number
    @phone_number
  end
  def phone_number=(str)
    @phone_number = str
  end

  def telegram
    @telegram
  end
  def telegram=(str)
    @telegram = str
  end

  def email
    @email
  end
  def email=(str)
    @email = str
  end

  def git
    @git
  end
  def git=(str)
    @git = str
  end

end
