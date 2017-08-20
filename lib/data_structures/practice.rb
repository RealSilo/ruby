require 'byebug'

class Vertex
  attr_reader :connections

  def initialize
    @connections = {}
  end

  def add_connection(to_key, weight = 0)
    @connections[to_key] = weight
  end

  def delete_connection(to_key)
    @connections.delete(to_key)
  end
end

class Graph
  def initialize
    @vertices = {}
    @vertice_number = 0
  end

  def add_vertex(key)
    vertex = Vertex.new
    @vertices[key] = vertex
    @vertice_number += 1
    key
  end

  def find_vertex(key)
    @vertices[key]
  end

  def add_edge(from_key, to_key, weight = 0)
    add_vertex(from_key) unless @vertices[from_key]
    add_vertex(to_key) unless @vertices[to_key]
    @vertices[from_key].add_connection(to_key, weight)
  end

  def remove_edge(from_key, to_key)
    @vertices[from_key].delete_connection(to_key)
  end

  def vertice_list
    @vertices.keys
  end

  def bfs(root)
    visited = []
    queue = [root]

    while queue.any?
      vertex = queue.shift

      next if visited.include?(vertex)

      visited << vertex

      find_vertex(vertex).connections.each do |node, _data|
        queue << node unless visited.include?(node)
      end
    end

    visited
  end

  def dfs(root)
    visited = []
    stack = [root]

    while stack.any?
      vertex = stack.pop

      next if visited.include?(vertex)

      visited << vertex

      find_vertex(vertex).connections.each do |node, _data|
        stack << node unless visited.include?(node)
      end
    end

    visited
  end
end

data = {
  'A' => ['B', 'C'],
  'B' => ['A', 'D', 'E'],
  'C' => ['A', 'F'],
  'D' => ['B'],
  'E' => ['F'],
  'F' => []
}

graph = Graph.new

data.each do |key, connections|
  connections.each do |conn|
    graph.add_edge(key, conn)
  end
end

p graph.bfs('A')
p graph.dfs('A')



