require 'set'
require 'byebug'

class Graphs
  class Vertex
    UNVISITED = 0
    VISITED = 1

    attr_reader :id, :connections

    def initialize(key)
      @id = key
      @connections = {}
      @visited = UNVISITED
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
      return @vertex_list[key] if @vertex_list.include?(key)
      nil
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

  graph = Graph.new
  atlanta = graph.add_vertex('Atlanta')
  graph.add_vertex('Boston')
  graph.add_vertex('Chicago')
  graph.add_vertex('Denver')
  graph.add_vertex('El Paso')
  graph.add_edge('Atlanta', 'Boston', 100)
  graph.add_edge('Atlanta', 'Denver', 160)
  graph.add_edge('Boston', 'Chicago', 120)
  graph.add_edge('Boston', 'Denver', 180)
  graph.add_edge('Chicago', 'El Paso', 80)
  graph.add_edge('Denver', 'Chicago', 40)
  graph.add_edge('Denver', 'El Paso', 140)

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

    visited = []
    current = root

    while current
      visited << current

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
        unless value[:weight] >= cheapest_route_from_current || visited.include?(key)
          cheapest_route_from_current = value[:weight]
          current = key
        end
      end
    end

    routes
  end

  p Graphs.new.dijkstra(atlanta, graph)

  # Depth-First Search (DFS)
  # it explores possible vertices down each branch before backtracking
  # this feature allows the algorithm to be implemented succinctly both
  # in iterative and recursive forms

  # Greedy algorithm
  # time complexity: O(V+E)

  # mark the current vertex visited
  # explorce each adjacent vertex that is not included in the visited set

  def dfs(graph, start_node)
    visited = [].to_set
    stack = [start_node]

    while stack.any?
      vertex = stack.pop

      next unless visited.include?(vertex)

      visited.add(vertex)

      graph[vertex].each do |node|
        stack << node unless visited.include?(node)
      end
    end

    visited
  end

  @@dfs_visited = [].to_set
  def dfs_with_recursion(graph, start_node)
    dfs_helper(graph, 'A')
    @@dfs_visited
  end

  def dfs_helper(graph, vertex)
    @@dfs_visited.add(vertex)

    graph[vertex].each do |node|
      dfs_helper(graph, node) unless @@dfs_visited.include?(node)
    end
  end

  simple_graph = {
    'A' => ['B', 'C'].to_set,
    'B' => ['A', 'D', 'E'].to_set,
    'C' => ['A', 'F'].to_set,
    'D' => ['B'].to_set,
    'E' => ['F'].to_set,
    'F' => [].to_set
  }

  p Graphs.new.dfs(simple_graph, 'A')
  p Graphs.new.dfs_with_recursion(simple_graph, 'A')

  simple_acyclic_graph = {
    'A' => ['C', 'B'].to_set,
    'B' => ['D', 'E'].to_set,
    'C' => ['F'].to_set,
    'D' => ['E'].to_set,
    'E' => ['F'].to_set,
    'F' => [].to_set
  }

  other_acyclic_graph = {
    'A' => ['B', 'C'],
    'B' => ['D'],
    'C' => ['D'],
    'D' => ['E', 'F'],
    'E' => ['G'],
    'F' => ['G'],
    'G' => []
  }

  # Topological sort
  # It uses modified DFS to find a topological order.

  @@tvisited = [].to_set
  @@tsorted = []
  def topological_sort(graph, root)
    topological_helper(graph, root)
    @@tsorted
  end

  def topological_helper(graph, vertex)
    @@tvisited.add(vertex)

    graph[vertex].each do |node|
      topological_helper(graph, node) unless @@tvisited.include?(node)
    end

    # When we are coming back from the last vertex of the recursive call stack
    # we add it to the array since there is no way an other element could come
    # after it as this is the last invocation in the stack.
    @@tsorted.unshift(vertex)
  end

  # p Graphs.new.topological_sort(simple_acyclic_graph, 'A')
  p Graphs.new.topological_sort(other_acyclic_graph, 'A')

  # Breadth-first search (BFS)
  # Questions to be answered by BFS
  # Is there a path from node A to node B?
  # What is the shortest path from node A to node B?

  # Greedy algorithm
  # time complexity: O(V+E)

  def bfs(graph, start_node)
    visited = [].to_set
    queue = [start_node]

    while queue.any?
      vertex = queue.shift

      next unless visited.include?(vertex)
      # an if else statement could be added here if we look
      # for some property that should stop the algorithm e.g.
      # shortest path to this node

      visited.add(vertex)

      graph[vertex].each do |node|
        queue << node unless visited.include?(node)
      end
    end

    visited
  end

  bfs_visit = Graphs.new.bfs(simple_graph, 'B')
  p bfs_visit

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

  adjacency_matrix = [
    [0, 1, 1, 1, 0],
    [0, 0, 1, 0, 0],
    [1, 1, 0, 0, 0],
    [0, 0, 0, 1, 0],
    [0, 1, 0, 0, 0]
  ]

  # distances = Graphs.new.distance_with_bfs(adjacency_matrix, 1)
  # p distances
end
