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

    while stack.length > 0
      vertex = stack.pop

      unless visited.include?(vertex)
        visited.add(vertex)
        stack += graph[vertex].to_a.reverse - visited.to_a
      end
    end

    visited
  end

  dfs_visit = Graphs.new.dfs(simple_graph, 'A')
  p dfs_visit

  def bfs(graph, start_node)
    visited = [].to_set
    queue = [start_node]

    while stack.length > 0
      vertex = queue.shift

      unless visited.include?(vertex)
        visited.add(vertex)
        queue += graph[vertex].to_a.reverse - visited.to_a
      end
    end

    visited
  end

  bfs_visit = Graphs.new.dfs(simple_graph, 'A')
  p bfs_visit
end
