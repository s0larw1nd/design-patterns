#task 2
def index_min(array)
  array.index(array.min)
end

#task 14
def find_between_a_b_position(array,a,b)
  [array.length, b].min - [-1, a].max - 1
end