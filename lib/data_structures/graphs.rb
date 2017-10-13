require 'set'
require 'byebug'

# In terms of programming there are two common ways to represent a graph:
# Adjacency List and Adjacency Matrix

# Adjacency list
# This is the most common way to represent a graph. Every vertex stores a list of
# adjacent vertices. You don't necessarily need any additional classes to
# represent a graph. An array or a hash table of lists (arrays, linked lists,
# etc.) can store the adjacency list.

# Adjacency matrix
# An adjacency matrix is an NxN matrix (where N is the number of nodes), where a
# 1 value at matrix[i][j] indicates an edge from node i to node j. The rest of
# the fields are 0-s.

# In the adjacency list representation, you can easily iterate through the
# neighbors of a node. In the adjacency matrix representation, you will need to
# iterate through all the nodes to identify a node's neighbors.

class Graphs
  class Vertex
    attr_reader :id, :connections

    def initialize(key)
      @id = key
      @connections = {}
    end

    def add_neighbor(nbr, weight = 0)
      @connections[nbr] = weight
    end

    def delete_neighbor(nbr)
      @connections.delete(nbr)
    end

    def weight(nbr)
      @connections[nbr]
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
      key
    end

    def vertex(key)
      @vertex_list[key]
    end

    def add_edge(from, to, weight = 0)
      add_vertex(from) unless @vertex_list[from]
      add_vertex(to) unless @vertex_list[to]

      @vertex_list[from].add_neighbor(to, weight)
    end

    def vertices
      @vertex_list.keys
    end
  end

  # Find the cheapest way from Atlanta to the other cities.
  # shortest path problem

  # Although our example here focused on finding the cheapest flight,
  # the same exact approach can be used for mapping and GPS technology.
  # If the weights on each edge represented how fast it would take to drive
  # from each city to the other rather than the price, we’d just as easily
  # use Dijkstra’s algorithm to determine which route you should take to drive
  # from one place to another.

  # What’s the shortest path to X?” for weighted graphs.

  # Greedy algorithm
  # Works only with directed acyclic graphs.
  # Can’t be used if there is a negative-weight edges

  # 1. We make the starting vertex our current vertex.
  # 2. We check all the vertices adjacent to the current vertex and calculate and
  #    record the weights from the starting vertex to all known locations.
  # 3. To determine the next current vertex, we find the cheapest unvisited known
  #    vertex that can be reached from our starting vertex.
  # 4. Repeat the first three steps until we have visited every vertex in the graph.
  def dijkstra(root, graph)
    routes = {}

    graph.vertices.each do |key|
      routes[key] = { weight: Float::INFINITY, parent: key }
    end

    routes[root] = { weight: 0, parent: root }

    visited = {}
    current = root

    while current
      visited[current] = 1

      graph.vertex(current).connections.each do |connected_vertex, weight_value|
        # If it is cheaper to get to this connected vertex by going thru
        # this (the current) node than the original value then update the
        # cost for this node
        # weight => Edge weight value to the connected vertex from the current node
        # routes[current][0] => cheapest way until the current node
        # routes[connected_vertex][0] => The current cheapest way to the connected
        # node that we examine
        if routes[connected_vertex][:weight] > weight_value + routes[current][:weight]
          routes[connected_vertex] = { weight: weight_value + routes[current][:weight], parent: current }
        end
      end

      current = nil
      cheapest_route_from_current = Float::INFINITY

      routes.each do |key, value|
        unless value[:weight] >= cheapest_route_from_current || visited[key]
          cheapest_route_from_current = value[:weight]
          current = key
        end
      end
    end

    routes
  end

  # graph = Graph.new
  # atlanta = graph.add_vertex('Atlanta')
  # graph.add_edge('Atlanta', 'Boston', 100)
  # graph.add_edge('Atlanta', 'Denver', 160)
  # graph.add_edge('Boston', 'Chicago', 120)
  # graph.add_edge('Boston', 'Denver', 180)
  # graph.add_edge('Chicago', 'El Paso', 80)
  # graph.add_edge('Denver', 'Chicago', 40)
  # graph.add_edge('Denver', 'El Paso', 140)
  # p Graphs.new.dijkstra(atlanta, graph)

  # Used to find the shortest path from a source node to every other node in any
  # edge-weighted digraph with negative or non-negative weights. It's slower than
  # Dijkstra's algorithm but it has the advantage of working with negative weights.
  # Notice, though, that it won't work if the graph has a negative cycle (i.e.
  # a cycle whose the sum of the edges' weight is a negative value, since any path
  # could be made shorter just with another walk, over and over).

  def bellman_ford(root, graph); end

  # Depth-First Search (DFS)
  # it explores possible vertices down each branch before backtracking
  # this feature allows the algorithm to be implemented succinctly both
  # in iterative and recursive forms

  # Greedy algorithm
  # time complexity: O(V+E)

  # mark the current vertex visited
  # explorce each adjacent vertex that is not included in the visited set

  # Implementation with the Graph/Vertex above
  def dfs(graph, start_node)
    visited = {}
    stack = [start_node]

    until stack.empty?
      vertex = stack.pop

      next if visited[vertex]

      visited[vertex] = 1

      graph.vertex(vertex).connections.each do |key, _weight|
        stack << key unless visited[key]
      end
    end

    visited.map { |k, _v| k }
  end

  def simple_dfs(graph, start_node)
    visited = {}
    stack = [start_node]

    while stack.any?
      vertex = stack.pop

      next if visited[vertex]

      visited[vertex] = 1

      graph[vertex].each do |node|
        stack << node unless visited[node]
      end
    end

    visited.map { |k, _v| k }
  end

  @@dfs_visited = {}
  def dfs_with_recursion(graph, start_node)
    dfs_helper(graph, start_node)
    @@dfs_visited
  end

  def dfs_helper(graph, vertex)
    @@dfs_visited[vertex] = 1

    graph[vertex].each do |node|
      dfs_helper(graph, node) unless @@dfs_visited[node]
    end
  end

  # Topological sort
  # It uses modified DFS to find a topological order.
  def topological_sort(graph, root, tsorted = [])
    topological_helper(graph, root, tsorted)
    tsorted
  end

  def topological_helper(graph, vertex, tsorted, visited = {})
    visited[vertex] = 1

    graph[vertex].each do |node|
      topological_helper(graph, node, tsorted, visited) unless visited[node]
    end

    # When we are coming back from the last vertex of the recursive call stack
    # we add it to the array since there is no way an other element could come
    # after it as this is the last invocation in the stack.
    tsorted.unshift(vertex) unless tsorted.include?(vertex)
  end

  # Breadth-first search (BFS)
  # Questions to be answered by BFS
  # Is there a path from node A to node B?
  # What is the shortest path from node A to node B?

  # Greedy algorithm
  # time complexity: O(V+E)
  def bfs(graph, start_node)
    visited = {}
    queue = [start_node]

    while queue.any?
      vertex = queue.shift

      next if visited[vertex]
      visited[vertex] = 1

      graph.vertex(vertex).connections.each do |key, _weight|
        queue << key unless visited[key]
      end
    end

    visited.map { |k, _v| k }
  end

  def simple_bfs(graph, start_node)
    visited = {}
    queue = [start_node]

    while queue.any?
      vertex = queue.shift

      next if visited[vertex]
      # an if else statement could be added here if we look
      # for some property that should stop the algorithm e.g.
      # shortest path to this node

      visited[vertex] = 1

      graph[vertex].each do |node|
        queue << node unless visited[node]
      end
    end

    visited.map { |k, _v| k }
  end

  def shortest_path_with_bfs(graph, start_node, to_node)
    queue = [[start_node]]
    visited = {}

    while queue.any?
      path = queue.shift
      vertex = path[-1]

      return path if vertex == to_node
      next if visited[vertex]
      visited[vertex] = 1

      graph[vertex].each do |node|
        new_path = Array.new(path)
        new_path << node
        queue << new_path
        return new_path if node == to_node
      end
    end
  end

  # The following solution uses adjacency matrix
  def distance_with_bfs(graph, root)
    node_lengths = {}

    graph.each_with_index do |_val, index|
      node_lengths[index] = Float::INFINITY
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
        if node_lengths[idx] == Float::INFINITY
          node_lengths[idx] = node_lengths[current] + 1
          queue.push(idx)
        end
      end
    end

    node_lengths
  end
end

# Find the largest non-zero region in an m*n matrix.
# Modified BFS

# 5 in the following case:
# 1 1 0 0
# 0 1 1 0
# 0 0 1 0
# 1 0 0 0
def connected_max(arr)
  visited = {}
  largest = 0

  arr.each_with_index do |row, i|
    row.each_with_index do |_col, j|
      next if arr[i][j] == 0
      next if visited["#{i}:#{j}"]

      queue = [[i, j]]
      current = 0

      while queue.any?
        element = queue.shift

        k = element[0]
        l = element[1]
        next if visited["#{k}:#{l}"]
        visited["#{k}:#{l}"] = 1
        current += 1

        -1.upto(1) do |m|
          -1.upto(1) do |n|
            if (k + m) >= 0 && (k + m) < arr.length && (l + n) >= 0 && (l + n) < arr[0].length
              next if arr[k + m][l + n] == 0 || visited["#{k + m}:#{l + n}"]
              queue << [k + m, l + n]
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
