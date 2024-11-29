require_relative "Student"
require 'date'

class BinarySearchTree
  include Enumerable

  class Node
    attr_accessor :value, :left, :right
  
    def initialize(value)
      @value = value
      @left = nil
      @right = nil
    end
  end

  def initialize
    @root = nil
  end

  def insert(student)
    raise ArgumentError.new("Ошибка: требуется передать аргумент класса Student") unless student.is_a?(Student)
    @root = insert_node(@root, student)
  end

  def each(mode = "dfs", &block)
    send mode.to_sym, &block
  end

  private
  def insert_node(node, value)
    return Node.new(value) if node.nil?

    if value <= node.value
      node.left = insert_node(node.left, value)
    else
      node.right = insert_node(node.right, value)
    end

    node
  end

  def bfs(&block)
    queue = [@root]
    res = []
    until queue.empty?
      next_element = queue.shift
      unless next_element.nil?
        res << next_element.value
        queue += [next_element.left, next_element.right]
      end
    end

    res.each(&block)
  end

  def dfs(&block)
    stack = [@root]
    res = []
    until stack.empty?
      next_element = stack.pop
      unless next_element.nil?
        res << next_element.value
        stack += [next_element.right, next_element.left]
      end
    end

    res.each(&block)
  end
end