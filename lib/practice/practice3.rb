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

  def symmetric?(node = @root)
    equal?(reverse(node.left), node.right)
  end

  private

  def equal?(node1, node2)
    return true if node1.nil? && node2.nil?
    return false if node1.nil? || node2.nil?
    equal?(node1.left, node2.left) && equal?(node1.right, node2.right)
  end

  def reverse(node)
    return if node.nil?

    node.left, node.right = reverse(node.right), reverse(node.left)

    node
  end

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

class EightQueen
  SIZE = 8

  attr_accessor :board

  def initialize
    @board = Array.new(SIZE) { Array.new(SIZE, 0) }
    @solution_found = false
  end

  def place_queens
    place_queen_in_col(0)
  end

  private

  def place_queen_in_col(row)
    SIZE.times do |col|
      if safe?(row, col)
        @board[row][col] = 1
        if row == SIZE - 1
          @solution_found = true
        else
          place_queen_in_col(row + 1)
        end
      end

      break if @solution_found
      @board[row][col] = 0
    end
  end

  def safe?(row, col)
    safe_horizontally?(row) &&
    safe_vertically?(col) &&
    safe_diagonally?(row, col)
  end

  def safe_horizontally?(row)
    @board[row].all? { |val| val == 0 }
  end

  def safe_vertically?(col)
    @board.each do |row|
      return false unless row[col] == 0
    end
    true
  end

  def safe_diagonally?(row, col)
    @board.each_with_index do |r, row_index|
      r.each_with_index do |cell_val, col_index|
        if cell_val == 1 && (row_index - row).abs == (col_index - col).abs
          return false
        end
      end
    end
    true
  end
end

def eight_queens
  board = EightQueen.new.board
  solution_found = false
  place_queen_in_col(board, 0, solution_found)
  # print board.board
end

eq = EightQueen.new
eq.place_queens
eq.board.each do |row|
  p row
end

# 0,0 is the middle -> [[1, 2], [-1, 2], [-3, -4]]
def k_closest_points(arr, k)
  temp = []
  
  arr[0..k-1].each do |coords|
    temp << Math.sqrt((coords[0] ** 2 + coords[1] ** 2))
  end

  arr[k..-1].each do |coords|
    distance = Math.sqrt((coords[0] ** 2 + coords[1] ** 2))

    max_idx = 0
    temp.each_with_index { |temp_dist, i| max_idx = i if temp_dist > temp[max_idx] }

    temp[max_idx] = distance if distance < temp[max_idx]
  end

  temp
end

p k_closest_points([[1, 2], [6, -6], [-1, 2], [-3, -4]], 3)

def lowest_common_ancestor
end