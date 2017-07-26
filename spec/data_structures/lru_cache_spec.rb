require_relative '../../lib/data_structures/lru_cache'
require 'byebug'

describe LruCache do
  let(:lru) { described_class.new(3) }

  describe '#set' do
    context 'without size overflow' do
      before do
        lru.set('a', 1)
        lru.set('b', 2)
        lru.set('c', 3)
      end

      it 'sets the head' do
        expect(lru.head.data).to eq 1
      end

      it 'sets the tail' do
        expect(lru.tail.data).to eq 3
      end

      it 'sets the next nodes' do
        expect(lru.head.next_node.data).to eq 2
        expect(lru.head.next_node.next_node.data).to eq 3
      end

      it 'sets the prev nodes' do
        expect(lru.tail.prev_node.data).to eq 2
        expect(lru.tail.prev_node.prev_node.data).to eq 1
      end
    end

    context 'with size overflow' do
      before do
        lru.set('a', 1)
        lru.set('b', 2)
        lru.set('c', 3)
        lru.get('a')
        lru.set('d', 4)
      end

      it 'sets the head' do
        expect(lru.head.data).to eq 3
      end

      it 'sets the tail' do
        expect(lru.tail.data).to eq 4
      end

      it 'sets the next nodes' do
        expect(lru.head.next_node.data).to eq 1
        expect(lru.head.next_node.next_node.data).to eq 4
      end

      it 'sets the prev nodes' do
        expect(lru.tail.prev_node.data).to eq 1
        expect(lru.tail.prev_node.prev_node.data).to eq 3
      end

      it 'contains the correct keys' do
        expect(lru.store.keys).to eq ['a', 'c', 'd'];
      end
    end
  end

  describe '#get' do
    before do
      lru.set('a', 1)
      lru.set('b', 2)
      lru.set('c', 3)
      lru.get('a')
      lru.get('c')
    end

    it 'reorders the elements' do
      expect(lru.head.data).to eq 2
      expect(lru.head.next_node.data).to eq 1
      expect(lru.head.next_node.next_node.data).to eq 3

      expect(lru.tail.data).to eq 3
      expect(lru.tail.prev_node.data).to eq 1
      expect(lru.tail.prev_node.prev_node.data).to eq 2
    end
  end
end
