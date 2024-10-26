#task 2
def min_index(array)
  min_ind = yield array
end
min_idx = min_index([3,2,1,4,5,3]) { |array| array.index(array.min) }

#task 14
def find_between_a_b(array,a,b)
  k_elem = yield array,a,b
end

k_elem = find_between_a_b([0,1,2,3,4,5,6,7],1,6) do |array,a,b|
  from = [-1, a].max
  to = [array.length, b].min
  k = to - from - 1
end

#task 26
def find_between_min(array)
  k_elem = yield array
end

k_elem_min = find_between_min([1,2,2,1]) do |array|
  min_elem = array.min
  k = array.rindex(min_elem) - array.index(min_elem) - 1
end

#task 38
def find_between_a_b(array,a,b)
  k_elem = yield array,a,b
end

k_elem_a_b = find_between_a_b([1,2,3,4,5,6,7,8],3,6) do |array,a,b|
  k_elem = 0
  array.each do |elem|
    k_elem += 1 if elem.between?(a,b)
  end
  k_elem
end

#task 50
def find_difference_lists(l1,l2)
  diff_list = yield l1, l2
end

diff_list = find_difference_lists([1, 1, 2, 4, 6, 6], [1, 2, 2, 2, 8, 10]) do |l1,l2|
  l1_l2 = l1 - l2
  for i in l1
    l1_l2.delete(i) if l1.count(i) > 1
  end
  l2_l1 = l2 - l1
  for i in l1
    l2_l1.delete(i) if l2.count(i) > 1
  end
  l1_l2 + l2_l1
end

puts "Введите номер задачи для решения: "
task_num = gets

puts "Откуда считывать информацию: /n1.Файл/n2.Клавиатура/n"
inp = gets

if inp == '1':
  puts "Введите название файла: "
  file_path = gets
  raise StandardError.new 'Ошибка: файл не существует' unless File.file?(file_path)
  begin
    file = File.open(file_path, "r")
    input_data = file.first()
    case task_num
    when '2'
      arr = input_data.split(',')
      result = min_index(arr) { |array| array.index(array.min) }
      puts result
    when '14'
      arr = input_data.split(' ')
      result = find_idx_between_a_b(arr[0].split(','), arr[1].split(',')[0], arr[2].split(',')[1]) do |array,a,b|
        from = [-1, a].max
        to = [array.length, b].min
        k = to - from - 1
      end
      puts result
    when '26'
      arr = input_data.split(',')
      result = find_between_min(arr) do |array|
        min_elem = array.min
        k = array.rindex(min_elem) - array.index(min_elem) - 1
      end
      puts result
    when '38'
      arr = input_data.split(' ')
      result = find_values_between_a_b(arr[0].split(','), arr[1].split(',')[0], arr[2].split(',')[1]) do |array,a,b|
        k_elem = 0
        array.each do |elem|
          k_elem += 1 if elem.between?(a,b)
        end
        k_elem
      end
      puts result
    when '50'
      arr = input_data.split(' ')
      result = ind_difference_lists(arr[0].split(','), arr[1].split(',')) do |l1,l2|
        l1_l2 = l1 - l2
        for i in l1
          l1_l2.delete(i) if l1.count(i) > 1
        end
        l2_l1 = l2 - l1
        for i in l1
          l2_l1.delete(i) if l2.count(i) > 1
        end
        l1_l2 + l2_l1
      end
      puts result
  ensure
    file.close unless file.nil?
  end

elsif inp == '2':
  case task_num
  when '2'
    puts 'Введите массив: \n'
    arr = gets.split(',')
    puts min_index(arr)
  when '14'
    puts 'Введите массив: \n'
    arr = gets.split(',')
    puts 'Введите a: \n'
    a = gets
    puts 'Введите b: \n'
    b = gets
    puts find_idx_between_a_b(arr, a, b)
  when '26'
    puts 'Введите массив: \n'
    arr = gets.split(',')
    puts find_between_min(arr)
  when '38'
    puts 'Введите массив: \n'
    arr = gets.split(',')
    puts 'Введите a: \n'
    a = gets
    puts 'Введите b: \n'
    b = gets
    puts find_values_between_a_b(arr, a, b)
  when '50'
    puts 'Введите массив L1: \n'
    arr1 = gets.split(',')
    puts 'Введите массив L2: \n'
    arr2 = gets.split(',')
    puts find_difference_lists(arr1, arr2)
