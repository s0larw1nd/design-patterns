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

  def bfs(&block)
    queue = [@root]
    until queue.empty?
      next_element = queue.shift
      unless next_element.nil?
        yield next_element.value
        queue += [next_element.left, next_element.right]
      end
    end
  end

  def dfs(&block)
    stack = [@root]
    until stack.empty?
      next_element = stack.pop
      unless next_element.nil?
        yield next_element.value
        stack += [next_element.right, next_element.left]
      end
    end
  end

  private
  def insert_node(node, value)
    return Node.new(value) if node.nil?

    if value.birth_date <= node.value.birth_date
      node.left = insert_node(node.left, value)
    else
      node.right = insert_node(node.right, value)
    end

    node
  end
end