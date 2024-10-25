class BlockArray
  def initialize(array)
    @array = array
  end

  def all?(&block)
    if block_given?
      for elem in @array
        return false if block.call(elem) == false  
      end
    else
      for elem in @array
        return false if elem.nil? || elem == false
      end
    end
    return true
  end

  def flat_map(&block)
    raise StandardError.new "Требуется передать блок в функцию" if !block_given?
    result_array = []
    for elem in @array
      new_elem = block.call(elem)
      if new_elem.instance_of? Array then result_array += new_elem else result_array.append(new_elem) end
    end
    return result_array
  end

  def one?(&block)
    k = 0
    if block_given?
      for elem in @array
        k += 1 if block.call(elem)
      end
      return k == 1
    end
    for elem in @array
      k += 1 if elem
    end
    return k == 1
  end

  def inject(initial_memo = (no_value_set_by_user = true; @array[0]), &block)
    raise StandardError.new "Требуется передать блок в функцию" if !block_given?
    memo = initial_memo
    no_value_set_by_user == true ? start_id = 1 : start_id = 0
    for element in @array[start_id..-1]
      memo = block.call(memo, element)
    end
    return memo
  end
  
  def min_by(k_min=1, &block)
    raise StandardError.new "Требуется передать блок в функцию" if !block_given?
    raise IndexError.new "Количество минимальных элементов больше длины массива" if k_min > @array.length
    min_elems = [@array[0]]
    for elem_a in @array[1..k_min]
      for id_elem_me in 0..k_min
        if min_elems[id_elem_me].nil? 
          min_elems.append(elem_a)
          break
        elsif !min_elems[id_elem_me+1].nil? && block.call(elem_a).between?(block.call(min_elems[id_elem_me]), block.call(min_elems[id_elem_me+1]))
          min_elems.insert(id_elem_me+1, elem_a)
          break
        end
      end
    end

    for elem_a in @array[1..@array.length()-1]
      for id_elem_me in 0..min_elems.length-1
        if block.call(min_elems[id_elem_me]) > block.call(elem_a)
          min_elems.insert(id_elem_me,elem_a)
          min_elems = min_elems[0..[0,k_min-1].max]
          break
        end
      end
    end
    
    if k_min == 1 then return min_elems[0] else return min_elems end
  end

  def find(ifnone = (no_value_set_by_user = true; nil), &block)
    raise StandardError.new "Требуется передать блок в функцию" if !block_given?
    for elem in @array
      return elem if block.call(elem)
    end
    if no_value_set_by_user == true
      return nil
    else
      return ifnone.call
    end
  end
end