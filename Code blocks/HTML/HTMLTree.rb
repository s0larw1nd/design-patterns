require_relative 'Tag'

class HTMLTree
  include Enumerable
  attr_accessor :root

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

  def each(mode = "dfs", &block)
    send mode.to_sym, &block
  end

  private
  def bfs(&block)
    queue = [@root]
    res = []
    until queue.empty?
      next_element = queue.shift
      res << next_element
      queue += next_element.children
    end

    res.each(&block)
  end

  def dfs(&block)
    stack = [@root]
    res = []
    until stack.empty?
      next_element = stack.pop
      res << next_element
      stack += next_element.children.reverse
    end

    res.each(&block)
  end
end