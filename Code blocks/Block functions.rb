#task 2
def min_index(array)
  min_ind = yield array
end
min_idx = min_index([3,2,1,4,5,3]) { |array| array.index(array.min) }
puts min_idx