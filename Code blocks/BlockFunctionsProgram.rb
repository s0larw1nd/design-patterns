require "./BlockFunctions.rb"

puts "Введите номер задачи для решения: "
task_num = gets.chomp
raise ArgumentError.new("Некорректный номер задачи") unless ['2','14','26','38','50'].include?(task_num)

puts "Откуда считывать информацию: \n1.Файл\n2.Клавиатура\n"
inp = gets.chomp
raise ArgumentError.new("Некорректный номер") unless inp == '1' || inp == '2'

if inp == '1'
  puts "Введите название файла: "
  file_path = gets.chomp
  raise StandardError.new 'Ошибка: файл не существует' unless File.file?(file_path)
  begin
    file = File.open(file_path, "r")
    input_data = file.first().split(',').map(&:to_i)
    case task_num
    when '2'
      p index_min(input_data)
    when '14'
      a, b = file.readline.split(',').map(&:to_i)
      p find_between_a_b_position(input_data,a,b)
    when '26'
      p find_between_min(input_data)
    when '38'
      a, b = file.readline.split(',').map(&:to_i)
      p find_between_a_b_values(input_data,a,b)
    when '50'
      second_array = file.readline.split(',').map(&:to_i)
      p find_difference_lists(input_data,second_array)
    end
  rescue => e
    puts "Ошибка при работе с файлом"
  ensure
    file.close unless file.nil?
  end

elsif inp == '2'
  puts 'Введите массив:'
  arr = gets.split(',').map(&:to_i)
  case task_num
  when '2'
    puts index_min(arr)
  when '14'
    puts 'Введите a:'
    a = gets.to_i
    puts 'Введите b:'
    b = gets.to_i
    puts find_between_a_b_position(arr, a, b)
  when '26'
    puts find_between_min(arr)
  when '38'
    puts 'Введите a:'
    a = gets.to_i
    puts 'Введите b:'
    b = gets.to_i
    puts find_between_a_b_values(arr, a, b)
  when '50'
    puts 'Введите второй массив:'
    arr2 = gets.split(',')
    puts find_difference_lists(arr, arr2)
  end
end