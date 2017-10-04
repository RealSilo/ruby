require 'byebug'

# class Vertex
#   attr_reader :connections

#   def initialize
#     @connections = {}
#   end

#   def add_connection(to_key, weight = 0)
#     @connections[to_key] = weight
#   end

#   def delete_connection(to_key)
#     @connections.delete(to_key)
#   end
# end

# class Graph
#   def initialize
#     @vertices = {}
#     @vertice_number = 0
#   end

#   def add_vertex(key)
#     vertex = Vertex.new
#     @vertices[key] = vertex
#     @vertice_number += 1
#     key
#   end

#   def find_vertex(key)
#     @vertices[key]
#   end

#   def add_edge(from_key, to_key, weight = 0)
#     add_vertex(from_key) unless @vertices[from_key]
#     add_vertex(to_key) unless @vertices[to_key]
#     @vertices[from_key].add_connection(to_key, weight)
#   end

#   def remove_edge(from_key, to_key)
#     @vertices[from_key].delete_connection(to_key)
#   end

#   def vertice_list
#     @vertices.keys
#   end

#   def bfs(root)
#     visited = []
#     queue = [root]

#     while queue.any?
#       vertex = queue.shift

#       next if visited.include?(vertex)

#       visited << vertex

#       find_vertex(vertex).connections.each do |node, _data|
#         queue << node unless visited.include?(node)
#       end
#     end

#     visited
#   end

#   def dfs(root)
#     visited = []
#     stack = [root]

#     while stack.any?
#       vertex = stack.pop

#       next if visited.include?(vertex)

#       visited << vertex

#       find_vertex(vertex).connections.each do |node, _data|
#         stack << node unless visited.include?(node)
#       end
#     end

#     visited
#   end
# end

# data = {
#   'A' => ['B', 'C'],
#   'B' => ['A', 'D', 'E'],
#   'C' => ['A', 'F'],
#   'D' => ['B'],
#   'E' => ['F'],
#   'F' => []
# }

# graph = Graph.new

# data.each do |key, connections|
#   connections.each do |conn|
#     graph.add_edge(key, conn)
#   end
# end

# p graph.bfs('A')
# p graph.dfs('A')

# def minNum(a, k, po)
#   a = a.to_f
#   k = k.to_f
#   po = po.to_f

#   if (k - a) / po > 1 || (k - a) / po == 0
#     1
#   elsif (k - a) / po > 0
#     ((1 / ((k - a) / po)) + 1).to_i
#   else
#     0
#   end
# end

# p minNum(3, 5, 1)
# p minNum(4, 5, 1)
# p minNum(4, 5, 10)
# p minNum(5, 4, 10)
# p minNum(5, 5, 10)

# n = 24

# def bfs(n, x, y)
#   queue = [[0, 0]]
#   visited = []
#   to_node = [n - 1, n - 1]
#   distances = {}
#   distances["#{0}#{0}"] = 0

#   while queue.any?
#     vertex = queue.shift

#     return distances["#{vertex[0]}#{vertex[1]}"] if vertex == to_node
#     next if visited.include?(vertex)
#     visited << vertex
      
#     neighbors = []
#     neighbors << [vertex[0] + x, vertex[1] + y] unless vertex[0] + x > n - 1 || vertex[1] + y > n - 1
#     neighbors << [vertex[0] + x, vertex[1] - y] unless vertex[0] + x > n - 1 || vertex[1] - y < 0
#     neighbors << [vertex[0] - x, vertex[1] + y] unless vertex[0] - x < 0 || vertex[1] + y > n - 1
#     neighbors << [vertex[0] - x, vertex[1] - y] unless vertex[0] - x < 0 || vertex[1] - y < 0
#     neighbors << [vertex[0] + y, vertex[1] + x] unless vertex[0] + y > n - 1 || vertex[1] + x > n - 1
#     neighbors << [vertex[0] + y, vertex[1] - x] unless vertex[0] + y > n - 1 || vertex[1] - x < 0
#     neighbors << [vertex[0] - y, vertex[1] + x] unless vertex[0] - y < 0 || vertex[1] + x > n - 1
#     neighbors << [vertex[0] - y, vertex[1] - x] unless vertex[0] - y < 0 || vertex[1] - x < 0
    

#     neighbors.each do |node|
#       unless visited.include?(node)
#           distances["#{node[0]}#{node[1]}"] = distances["#{vertex[0]}#{vertex[1]}"] + 1
#           queue << node
#       end
#     end
#   end
  
#   return -1
# end

# table = Array.new(n - 1) { Array.new(n - 1) { 0 } }

# 0.upto(n - 2) do |i|
#     i.upto(n - 2) do |j|
#         table[i][j] = bfs(n, i + 1, j + 1)
#     end
# end

# table.each_with_index do |row, i|
#     row.each_with_index do |_cell, j|
#         table[i][j] = table[j][i] if table[i][j] == 0
#     end
# end

# table.each do |row|
#     puts row.join(' ')
# end

def min_loss(data)
    orig_index = data.map.with_index.sort.map(&:last)
    data = data.sort
    
    diff = 10 ** 2
    
    data.each_with_index do |num, i|
        if data[i + 1] && data[i + 1] - data[i] > 0 && data[i + 1] - data[i] < diff && orig_index[i + 1] < orig_index[i]
            diff = data[i + 1] - data[i]
        end
    end
    
    diff
end

# p min_loss([0, 9, 3])


# PROBLEM
def connected_max(arr)
  visited = []
  largest = 0

  arr.each_with_index do |row, i|
    row.each_with_index do |_col, j|
      next if arr[i][j] == 0
      next if visited.include?([i, j])

      queue = []
      queue << [i, j]
      current = 0

      while queue.any?
        element = queue.shift
        next if visited.include?(element)
        visited << element
        current += 1

        k = element[0]
        l = element[1]

        (-1).upto(1) do |m|
          (-1).upto(1) do |n|
            if (k + m) >= 0 && (k + m) < arr.length && (l + n) >= 0 && (l + n) < arr[0].length
              unless arr[k + m][l + n] == 0 || visited.include?([k + m, l + n])
                queue << [k + m, l + n]
              end
            end
          end
        end
      end

      largest = current if current > largest
    end
  end

  largest
end

# p connected_max([[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 1, 0], [1, 0, 0, 0]])

# You buy stocks and you wanna maximize your profit. You have to sell later
# than you bought.

# [5, 10, 4, 6, 12] should return 12 - 4 = 8

# This greedy solution uses O(N) time and O(1) space.
def max_profit(arr)
  min = arr.first
  diff = 0

  arr.each do |element|
    diff = [element - min, diff].max
    min = [element, min].min
  end

  diff
end

# p max_profit([5, 10, 4, 6, 12])

def is_match(text, pattern, text_index = 0, pat_index = 0)
  # base case, one of the indexes reached the end
  if text_index >= text.length
    return true if pat_index >= pattern.length
    if pat_index + 1 < pattern.length && pattern[pat_index + 1] == '*'
      is_match(text, pattern, text_index, pat_index + 2)
    else
      false
    end
  # if we need a next pattern match but there is none
  elsif pat_index >= pattern.length && text_index < text.length
    return false
  # string matching for character followed by '*'
  elsif pat_index + 1 < pattern.length && pattern[pat_index + 1] == '*'
    if pattern[pat_index] == '.' || text[text_index] == pattern[pat_index]
      is_match(text, pattern, text_index, pat_index + 2) || is_match(text, pattern, text_index + 1, pat_index)
    else
      is_match(text, pattern, text_index, pat_index + 2)
    end
  # string matching for ordinary char or '.'
  elsif pattern[pat_index] == '.' || pattern[pat_index] == text[text_index]
    is_match(text, pattern, text_index + 1, pat_index + 1)
  else
    false
  end
end

# p is_match('abaa', 'a.*a*')

# class Solution
#     @@nodes = []
#     # @param a : array of integers
#     # @return an integer
#     class Node
#         attr_accessor :value, :children, :parent
#         def initialize(value, parent = nil)
#             @children = []
#             @value = value 
#         end
#     end
    
#     def height(node = @@nodes[0])
#         return 0 if node.nil?
        
#         values = []
#         node.children.each do |child|
#             values << height(child)
#         end
#         (values.max || 0) + 1
#     end

#     def diameter(node = @@nodes[0])
#         return 0 if node.nil?
        
#         height_vals = []
#         node.children.each do |child|
#             height_vals << height(child)
#         end
        
#         return 0 if height_vals.empty?
#         return height_vals[0] if height_vals.length == 1
        
#         diameters = []
#         node.children.each do |child|
#             diameters << diameter(child)
#         end
 
#         two_heights = height_vals.combination(2).to_a
#         two_diams = diameters.combination(2).to_a

#         max = 0
#         two_heights.each_with_index do |e, i|
#           new_max = [two_heights[i][0] + two_heights[i][1] + 1, two_diams[i].max].max
#           max = [max, new_max].max
#         end

#         max
#     end
    
#     def solve(a)
#         return 0 if a.length == 1
#         a.each_with_index do |val, i|
#             node = Node.new(i)
#             @@nodes << node
#             @@nodes[val].children << node unless val == -1
#         end
#         diameter(@@nodes[0])
#     end

#     def solve2(a)
#         return 0 if a.length == 1
#         a.each_with_index do |val, i|
#             node = Node.new(i)
#             node.parent = @@nodes[val] unless val == -1
#             @@nodes << node
#             @@nodes[val].children << node unless val == -1
#         end
#         @@nodes
#         bfsa(a)
#     end

#     def bfsa(a, root = @@nodes[0])
#       node_lengths = {}
      
#       a.each_with_index do |_val, index|
#         node_lengths[index] = Float::INFINITY
#       end
      
#       visited = []
#       queue = [[root, 0]]
#       dist = 0
      
#       while queue.any?
#           vertex = queue.shift
#           dist = [vertex[1], dist].max
#           visited << vertex
          
#           connections = vertex.children
#           connections << vertex.parent if vertex.parent
          
#           connections.each do |connection|
#               queue << [connection, vertex[1] + 1] unless visited.include?(connection)
#           end
#       end
      
#       max
#     end
# end

# p Solution.new.solve2([-1, 0, 0, 0, 3])

# class Product
#   attr_reader :name, :categories

#   def initialize(name)
#     @name = name
#     @categories = []
#   end

#   def add_category(category)
#     @categories << category
#     category.products << self
#   end
# end

# class Category
#   attr_reader :name, :products

#   def initialize(name)
#     @name = name
#     @products = []
#   end

#   def add_product(product)
#     @products << product
#     product.categories << self
#   end
# end

# product = Product.new('shirt')
# category = Category.new('clothes')
# product.add_category(category)
# p category.products

birth_data_date = {
  '1985': [
    { 'Peter': { 'birthplace': 'Baltimore', 'hospital': 'St Mary' }},
    { 'Tom': { 'birthplace': 'Chicago', 'hospital': 'St Stephen' }},
    { 'Andy': { 'birthplace': 'Washington', 'hospital': 'St Stephen' }},
    { 'John': { 'birthplace': 'San Francisco', 'hospital': 'UCSF Medical Center' }}
  ],
  '1986': [
    { 'Jack': { 'birthplace': 'New Jersey', 'hospital': 'General Hospital' }},
    { 'Tom': { 'birthplace': 'Washington', 'hospital': 'St Stephen' }},
    { 'Steven': { 'birthplace': 'Indianapolis', 'hospital': 'City Hospital' }},
    { 'Jack': { 'birthplace': 'Dallas', 'hospital': 'Dallas City Hospital' }}
  ],
  '1987': [
    { 'David': { 'birthplace': 'Pittsburgh', 'hospital': 'Pittsburgh Hospital' }},
    { 'Michael': { 'birthplace': 'Los Angeles', 'hospital': 'UCLA Medical Center' }},
    { 'Brad': { 'birthplace': 'New Jersey', 'hospital': 'General Hospital' }},
    { 'David': { 'birthplace': 'Kansas City', 'hospital': 'Kanas State Hospital' }}
  ],
  '1988': [
    { 'Peter': { 'birthplace': 'Boston', 'hospital': 'St Peter' }},
    { 'Tom': { 'birthplace': 'Pittsburgh', 'hospital': 'Pittsburgh Hospital' }}
  ],
  '1989': [
    { 'Donald': { 'birthplace': 'San Francisco', 'hospital': 'UCSF Medical Center' }},
    { 'Tom': { 'birthplace': 'Miami', 'hospital': 'Florida State Hospital' }},
    { 'Aaron': { 'birthplace': 'Seattle', 'hospital': 'Seattle Medical Center' }},
    { 'Aaron': { 'birthplace': 'Chicago', 'hospital': 'St Stephen' }}
  ]
}

# birthname_data = {
#   'Aaron': [
#     { 'date': '1989', 'birthplace': 'Seattle', 'hospital': 'Seattle Medical Center' },
#     { 'date': '1989', 'birthplace': 'Chicago', 'hospital': 'St Stephen' }
#   ]
# }
birth_data_name = {}

birth_data_date.each do |key, value|
  value.each do |hash|
    hash.each do |k, v|
      v.merge!('date': key.to_s)
      if birth_data_name[k.to_s]
        birth_data_name[k.to_s] << v
      else
        birth_data_name[k.to_s] = [v]
      end
    end
  end
end

puts birth_data_name['Peter']
