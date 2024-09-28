def coprime num
  k_coprime = 0
  for temp in 2..num:
    flag = 0
    for del in 2..temp:
      if num%del == 0 and temp%del == 0:
          flag = 1
          break
      end
    end
    k_coprime += 1 unless flag == 1
  end
  return k_coprime
end

def digits_sum num
  sum_digits = 0
  while num > 0 do
    if num % 10 % 3 == 0 then
      sum_digits += num % 10
    end
    num /= 10
  end

  return sum_digits
end

def num_divisor num
  k_max = 0
  for del in 2..num do
    if num % del == 0 then
      k_prost = 0
      temp = num
      while temp > 0 do
        temp_d = temp % 10
        valid = 1
        for dig_del in 2..[temp_d, del].max do
          if temp_d % dig_del == 0 and del % dig_del == 0 then
            valid = 0 
            break
          end
        end
        k_prost += 1 if valid == 1
        temp /= 10
      end
      
      if k_prost > k_max then
        k_max = k_prost
        del_max = del
      end
    end
  end

  return del_max
end
