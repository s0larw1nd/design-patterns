class HTMLTree
  include Enumerable
  attr_accessor :root

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
      @children.empty?
    end
  end

  def tagify(string)
    closing = string.include?("</")

    if string.include?(" ")
      name = string.split()[0]+">"
      params = string.split()[1..]
      params[-1].gsub!('>',"")
    else
      name = string.sub('</',"<")
    end

    return { :name => name, :params => params, :closing => closing}
  end

  def initialize(htmlstr)
    tags = htmlstr.gsub!('"',"'").scan(/<[A-z0-9\=\s\'\.\/\-,!]*>/).each.map(&method(:tagify)).reverse
    @root = nil
    insertNodes(tags, @root)
  end

  def insertNodes(tags, root)
    return if tags.empty?
    if @root.nil?
      @root = Tag.new(tags[0])
      @root.parent = nil
      if tags[0][:closing]
        insertNodes(tags[1..], @root)
      else
        insertNodes(tags[1..], nil)
      end
    else
      tag = Tag.new(tags[0])
      tag.parent = @root
      if tags[0][:closing]
        @root.children.unshift(tag)
        @root=tag
      elsif !tags[0][:closing] && tags[0][:name] == @root.value
        @root.parameters = tags[0][:params]
        if @root.parent!=nil then @root = @root.parent else return end
      else
        @root.children.unshift(tag)
      end
      insertNodes(tags[1..], @root)
    end
  end

  def bfs(&block)
    queue = [@root]
    until queue.empty?
      next_element = queue.shift
      yield next_element
      queue += next_element.children
    end
  end

  def dfs(&block)
    stack = [@root]
    until stack.empty?
      next_element = stack.pop
      yield next_element
      stack += next_element.children.reverse
    end
  end
end