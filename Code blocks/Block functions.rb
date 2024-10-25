#task 2
def min_index(array)
  min_ind = yield array
end
min_idx = min_index([3,2,1,4,5,3]) { |array| array.index(array.min) }
puts min_idx

#task 14
def find_between_a_b(array,a,b)
  k_elem = yield array,a,b
end

k_elem = find_between_a_b([0,1,2,3,4,5,6,7],1,6) do |array,a,b|
  from = [-1, a].max
  to = [array.length, b].min
  k = to - from - 1
end
puts k_elem

#task 26
def find_between_min(array)
  k_elem = yield array
end

k_elem_min = find_between_min([1,2,2,1]) do |array|
  min_elem = array.min
  k = array.rindex(min_elem) - array.index(min_elem) - 1
end
puts k_elem_min