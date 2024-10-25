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
end