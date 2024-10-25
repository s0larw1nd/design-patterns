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
end