#task 2
def index_min(array)
  array.index(array.min)
end

#task 14
def find_between_a_b_position(array,a,b)
  [array.length, b].min - [-1, a].max - 1
end

#task 26
def find_between_min(array)
  array.rindex(array.min) - array.index(array.min) - 1
end

#task 38
def find_values_between_a_b(array,a,b)
  array.select { |elem| elem.between?(a,b) }.length
end