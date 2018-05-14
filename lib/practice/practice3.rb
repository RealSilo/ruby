# puts "Enter A"
# a = gets.chomp
# puts "Enter B"
# b = gets.chomp
# c = a.to_i + b.to_i
# puts c

# array = []
# input = gets.chomp
# while
#   input != ''
#   array.push input
#   input = gets.chomp  
# end
# p array
require 'byebug'

class Node
  attr_accessor :key, :children, :value
  def initialize(key = '', value = false)
    @key = key
    @children = {}
    @value = value
  end
end

class AutoComplete
  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(string, node = @root)
    return if string.length == 0
    letter = string[0]
    if node.children[letter]
      if string.length == 1
        node.chidren[letter].value = true
        return
      end
      insert(string[1..-1], node.children[letter])
    else
      new_node = Node.new(letter)
      node.children[letter] =new_node
      if string.length == 1
        new_node.value = true
        return
      end
      insert(string[1..-1], new_node)
    end 
  end

  # def read(string, node = @root)
  #   return node_successors if string.length == 0
  #   letter = string[0]
  #   return nil unless node.children[letter]
  #   read(string[1..-1], node.children[letter])
  # end

  # def node_successors(node, words = [])
  #   if node.children.keys.none? && node.value
  #     words << 
  #   end
  # end
end

ac = AutoComplete.new
ac.insert('acbd');
byebug
p ac
# p ac.root

class BSTNode
  attr_accessor :left, :right, :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BST
  def initialize
    @root = nil
    @size = 0
  end

  def insert(value, node = @root)
    if @root
      insert_helper(value, @root)
    else
      @root = BSTNode.new(value)
    end
  end

  def find(value, node = @root)
    return nil unless node

    if node.value < value
      find(value, node.right)
    elsif node.value > value
      find(value, node.left)
    else
      node
    end
  end

  def find_min(value, node = @root)
    return nil unless node
    return node unless node.left
    find_min(value, node.left)
  end

  def delete(value, node, parent)
    return nil unless node

    if value < node.value
      delete(value, node.left, node)
    elsif node.value > value
      delete(value, node.right, node)
    else
      if node == @root
        new_root = node.left || node.right
        @root = new_root
      elsif node.left && node.right
      else
        connect_node = node.left || node.right
        if parent.left.value == value
          parent.left = connect_node
        elsif parent.right.value == value
          parent.right = connect_node
        end
      end
    end
  end

  private

  def insert_helper(value, node)
    if value < node.value
      if node.left
        insert_helper(value, node.left)
      else
        node.left = BSTNode.new(value, node)
      end
    else
      if node.right
        insert_helper(value, node.right)
      else
        node.right = BSTNode.new(value, node)
      end
    end
    @size += 1
  end
end

