class Tag
  attr_accessor :children, :value, :parent, :parameters
  def initialize(tag)
    @children = []
    @parent = nil
    @value = tag[:name]
    @parameters = tag[:params]
  end

  def to_s
    if !@parameters.nil?
      "#{@value[0..@value.length-2]} #{@parameters.join(' ')}>"
    else
      @value
    end
  end

  def children_count
    @children.length
  end

  def has_children?
    !@children.empty?
  end
end