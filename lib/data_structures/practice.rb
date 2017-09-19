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

p connected_max([[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 1, 0], [1, 0, 0, 0]])

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

p max_profit([5, 10, 4, 6, 12])
