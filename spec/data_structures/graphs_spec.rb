require_relative '../../lib/data_structures/graphs'
require 'byebug'

describe Graphs do
  subject { described_class.new }

  describe '#dijkstra' do
    subject { described_class.new }
    let(:graph) { Graphs::Graph.new }
    let!(:atlanta) { graph.add_vertex('Atlanta') }
    let(:distances) do
      [
        ['Atlanta', 'Boston', 100],
        ['Atlanta', 'Denver', 160],
        ['Boston', 'Chicago', 120],
        ['Boston', 'Denver', 180],
        ['Chicago', 'El Paso', 80],
        ['Denver', 'Chicago', 40],
        ['Denver', 'El Paso', 140]
      ]
    end

    before do
      distances.each do |data|
        graph.add_edge(data[0], data[1], data[2])
      end
    end

    it 'returns the shortest weighted path' do
      expect(subject.dijkstra(atlanta, graph)).to eq(
        'Atlanta'=> { weight: 0, parent: 'Atlanta' },
        'Boston'=> { weight: 100, parent: 'Atlanta' },
        'Denver'=> { weight: 160, parent: 'Atlanta' },
        'Chicago'=> { weight: 200, parent: 'Denver' },
        'El Paso'=> { weight: 280, parent: 'Chicago' }
      )
    end
  end

  describe '#dfs' do
    let(:graph) { Graphs::Graph.new }
    let(:data) do
      {
        'A' => ['B', 'C'],
        'B' => ['A', 'D', 'E'],
        'C' => ['A', 'F'],
        'D' => ['B'],
        'E' => ['F'],
        'F' => []
      }
    end

    before do
      data.each do |key, connections|
        connections.each do |conn|
          graph.add_edge(key, conn)
        end
      end
    end

    it 'returns the visited nodes' do
      expect(subject.dfs(graph, 'A')).to eq ['A', 'C', 'F', 'B', 'E', 'D']
    end
  end

  describe '#simpl_dfs' do
    let(:graph) do
      {
        'A' => ['B', 'C'],
        'B' => ['A', 'D', 'E'],
        'C' => ['A', 'F'],
        'D' => ['B'],
        'E' => ['F'],
        'F' => []
      }
    end

    it 'returns the visited nodes' do
      expect(subject.simple_dfs(graph, 'A')).to eq ['A', 'C', 'F', 'B', 'E', 'D']
    end
  end

  describe '#topological_sort' do
    let(:graph) do
      {
        'A' => ['B', 'C'],
        'B' => ['D'],
        'C' => ['D'],
        'D' => ['E', 'F'],
        'E' => ['G'],
        'F' => ['G'],
        'G' => []
      }
    end

    it 'sorts the graph topologically' do
      expect(subject.topological_sort(graph, 'A')).to eq(
        ['A', 'C', 'B', 'D', 'F', 'E', 'G']
      )
    end
  end

  describe '#bfs' do
    let(:graph) { Graphs::Graph.new }
    let(:data) do
      {
        'A' => ['B', 'C'],
        'B' => ['A', 'D', 'E'],
        'C' => ['A', 'F'],
        'D' => ['B'],
        'E' => ['F'],
        'F' => []
      }
    end

    before do
      data.each do |key, connections|
        connections.each do |conn|
          graph.add_edge(key, conn)
        end
      end
    end

    it 'returns the visited nodes' do
      expect(subject.bfs(graph, 'A')).to eq ['A', 'B', 'C', 'D', 'E', 'F']
    end
  end

  describe '#simple_bfs' do
    let(:graph) do
      {
        'A' => ['B', 'C'],
        'B' => ['A', 'D', 'E'],
        'C' => ['A', 'F'],
        'D' => ['B'],
        'E' => ['F'],
        'F' => []
      }
    end

    it 'returns the visited nodes' do
      expect(subject.simple_bfs(graph, 'A')).to eq ['A', 'B', 'C', 'D', 'E', 'F']
    end
  end

  describe '#simple_bfs_path_to' do
    let(:graph) do
      {
        'A' => ['B', 'C'],
        'B' => ['A', 'D', 'E'],
        'C' => ['A', 'F'],
        'D' => ['B'],
        'E' => ['F'],
        'F' => []
      }
    end

    it 'returns the shortest path' do
      expect(subject.shortest_path_with_bfs(graph, 'A', 'F')).to eq ['A', 'C', 'F']
    end
  end

  describe '#distance_with_bfs' do
    let(:matrix) do
      [
        [0, 1, 1, 1, 0],
        [0, 0, 1, 0, 0],
        [1, 1, 0, 0, 0],
        [0, 0, 0, 1, 0],
        [0, 1, 0, 0, 0]
      ]
    end

    it 'returns the distances from the root node' do
      expect(subject.distance_with_bfs(matrix, 1)).to eq(
        0 => 2,
        1 => 0,
        2 => 1,
        3 => 3,
        4 => Float::INFINITY
      )
    end
  end
end
