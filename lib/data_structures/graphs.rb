require 'set'
require 'byebug'

class Graphs
  class Vertex
    attr_reader :id

    def initialize(key)
      @id = key
      @connected_to = {}
    end

    def add_neighbor(nbr, weight = 0)
      @connected_to[nbr] = weight
    end

    def delete_neighbor(nbr)
      @connected_to.delete(nbr)
    end

    def connections
      @connected_to.keys
    end

    def weight(nbr)
      @connected_to[nbr]
    end
  end

  class Graph
    attr_reader :vertex_list

    def initialize
      @vertex_list = {}
      @vertices_number = 0
    end

    def add_vertex(key)
      @vertices_number += 1
      vertex = Vertex.new(key)
      @vertex_list[key] = vertex
      vertex
    end

    def vertex(key)
      return @vertex_list[key] if @vertex_list.include?(key)
      nil
    end

    def add_edge(from, to, weight = 0)
      add_vertex(from) unless @vertex_list[from]
      add_vertex(to) unless @vertex_list[to]

      @vertex_list[from].add_neighbor(@vertex_list[to], weight)
    end

    def vertices
      @vertex_list.keys
    end
  end

  # graph = Graph.new
  # 5.times { |i| graph.add_vertex(i) }
  # graph.add_edge(0, 1, 2)
  # p graph.vertex_list

  module Complex
    class State
      UNVISITED = 1
      VISITED = 2
      VISITING = 3
    end

    class Node
      def initialize(num)
        @num = num
        @visit_state = State::UNVISITED
        @adjacent = {}
      end

      def add_neighbor(nbr, weight = 0)
        @adjacent[nbr] = weight
      end
    end

    class Graph
      def initialize
        @nodes = {}
      end

      def add_node(num)
        node = Node.new(num)
        @nodes[num] = node
        node
      end

      def add_edge(from, to, weight = 0)
        add_node(from) unless @nodes[from]
        add_node(to) unless @nodes[to]

        @nodes[from].add_neighbor(@nodes[to], weight)
      end

      g = Graph.new
      g.add_edge(0, 1, 2)
      # p g.inspect
    end
  end

  # Depth-First Search (DFS)
  # it explores possible vertices down each branch before backtracking
  # this feature allows the algorithm to be implemented succinctly both
  # in iterative and recursive forms

  # mark the current vertex visited
  # explorce each adjacent vertex that is not included in the visited set

  simple_graph = {
    'A' => ['B', 'C'].to_set,
    'B' => ['A', 'D', 'E'].to_set,
    'C' => ['A', 'F'].to_set,
    'D' => ['B'].to_set,
    'E' => ['B', 'F'].to_set,
    'F' => ['C', 'E'].to_set
  }

  def dfs(graph, start_node)
    visited = [].to_set
    stack = [start_node]

    while stack.any?
      vertex = stack.pop

      unless visited.include?(vertex)
        visited.add(vertex)
        
        graph[vertex].each do |node|
          stack << node unless visited.include?(node)
        end
      end
    end

    visited
  end

  dfs_visit = Graphs.new.dfs(simple_graph, 'A')
  p dfs_visit

  def bfs(graph, start_node)
    visited = [].to_set
    queue = [start_node]

    while queue.any?
      vertex = queue.shift

      unless visited.include?(vertex)
        visited.add(vertex)

        graph[vertex].each do |node|
          queue << node unless visited.include?(node)
        end
      end
    end

    visited
  end

  bfs_visit = Graphs.new.bfs(simple_graph, 'B')
  p bfs_visit

  def distance_with_bfs(graph, root)
    node_lengths = {}

    graph.each_with_index do |_val, index|
      node_lengths[index] = nil
    end

    queue = [root]
    node_lengths[root] = 0

    while queue.any?
      current = queue.shift

      connections = graph[current]
      connection_indexes = []

      connections.each_with_index do |val, index|
        connection_indexes << index if val == 1
      end

      connection_indexes.each do |idx|
        if node_lengths[idx] == nil
          node_lengths[idx] = node_lengths[current] + 1
          queue.push(idx)
        end
      end
    end

    node_lengths
  end

  adjacency_matrix = [
    [0, 1, 1, 1, 0],
    [0, 0, 1, 0, 0],
    [1, 1, 0, 0 ,0],
    [0, 0, 0, 1, 0],
    [0, 1, 0, 0, 0]
  ]

  distances = Graphs.new.distance_with_bfs(adjacency_matrix, 1)
  p distances
end
