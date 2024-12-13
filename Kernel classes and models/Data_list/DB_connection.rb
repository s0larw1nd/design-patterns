require 'mysql2'

class DB_connection
  @instance = new
  @client = Mysql2::Client.new(
    host: "localhost",
    username: "root",
    password: "1234",
    database: "student"
  )

  private_class_method :new

  def self.instance
    @instance
  end

  def select()
    @client.query("SELECT * FROM student", symbolize_keys: true).to_a
  end
end