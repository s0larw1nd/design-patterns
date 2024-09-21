def first_positive arr
  idx = 0
  while idx < arr.length
    if Float(arr[idx])>0
      return idx
    end
    idx=idx+1
  end
  return -1 
end

def min_element arr
  min_el = Float(arr.first) 
  for elem in arr
    min_el = Float(elem) if Float(elem)<min_el
  end
  return min_el
end

raise StandardError.new 'Ошибка: файл не существует' unless File.file?(ARGV[1])
begin
  file = File.open(ARGV[1], "r")
  file_data = file.read.split(" ")
  method = ARGV[0]

  if method == "min_elem" or method == "1"
    puts min_element file_data

  elsif method == "first_pos" or method == "2"
    puts first_positive file_data

  else
    raise StandardError.new 'Ошибка: неверный метод'
  end
rescue ArgumentError
  puts "Ошибка: неверный формат данных"
rescue => e
  puts "Ошибка: #{e.message}"
ensure
  file.close unless file.nil?
end