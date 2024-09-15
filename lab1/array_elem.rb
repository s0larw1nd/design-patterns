def first_positive arr
  idx = 0
  while idx < arr.length
    if arr[idx].to_f>0
      return idx
    end
    idx=idx+1
  end
  return -1 
end

def min_element arr
  min_el = arr.first.to_f
  for elem in arr
    min_el = elem if elem.to_f<min_el.to_f
  end

  return min_el
end

method = ARGV.first
if File.file?(ARGV[1])
  file = File.open(ARGV[1])
  file_data = file.read.split(",")

  if method == "min_elem" or method == "1"
    puts min_element file_data

  elsif method == "first_pos" or method == "2"
    puts first_positive file_data

  else
    puts "Ошибка"
  end

else
  puts "Файл не существует"
end