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
end