#task 2
def index_min(array)
  array.index(array.min)
end

#task 14
def find_between_a_b_positions(array,a,b)
  [array.length, b].min - [-1, a].max - 1
end

#task 26
def find_between_min(array)
  array.rindex(array.min) - array.index(array.min) - 1
end

#task 38
def find_between_a_b_values(array,a,b)
  array.select { |elem| elem.between?(a,b) }.length
end

#task 50
def find_difference_lists(l1,l2)
  (l1.difference(l2) + l2.difference(l1)).filter { |elem| l1.count(elem) == l1.uniq.count(elem) && l2.count(elem) == l2.uniq.count(elem) }
end