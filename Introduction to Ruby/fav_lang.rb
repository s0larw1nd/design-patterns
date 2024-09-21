puts "Hello, #{ARGV.first}"
ARGV.clear

print "Какой твой любимый язык? "
lang = gets
exit if lang.nil? or lang.empty?
lang.chomp!

case lang.downcase
when "ruby"
  puts "Подлиза"
when "python" 
  puts "Хороший выбор, но скоро будет Ruby"
when "c++"
  puts "Сложно, скоро будет Ruby"
else
  puts "Cкоро будет Ruby"
end

print "\nВведите Ruby команду: "
comm_ruby = gets
comm_ruby.chomp!
begin
  eval "#{comm_ruby}"
rescue SyntaxError
  puts "Ошибка выполнения команды"
rescue NameError
  puts "Ошибка выполнения команды"
end


print "\nВведите shell команду: "
comm_shell = gets
comm_shell.chomp!
system( "#{comm_shell}" ) or puts "Ошибка выполнения команды"