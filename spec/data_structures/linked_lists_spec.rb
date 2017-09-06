require_relative '../../lib/data_structures/linked_lists'
require 'byebug'

describe LinkedLists do
  subject { described_class.new }

  describe '#cycle_in_linked_list?' do
    let(:s1) { LinkedLists::SinglyLinkedNode.new(2) }
    let(:s2) { LinkedLists::SinglyLinkedNode.new(3, s1) }
    let(:s3) { LinkedLists::SinglyLinkedNode.new(1, s2) }

    context 'with cycle' do
      before { s1.next_node = s3 }

      it 'returns true' do
        expect(subject.cycle_in_linked_list?(s3)).to be_truthy
      end
    end

    context 'without cycle' do
      it 'returns false' do
        expect(subject.cycle_in_linked_list?(s3)).to be_falsey
      end
    end
  end

  describe '#nth_to_the_last' do
    let(:s1) { LinkedLists::SinglyLinkedNode.new(2) }
    let(:s2) { LinkedLists::SinglyLinkedNode.new(3, s1) }
    let(:s3) { LinkedLists::SinglyLinkedNode.new(1, s2) }

    it 'returns the value of the nth element to the last' do
      expect(subject.nth_to_the_last(s3, 2)).to eq(s2.value)
    end
  end

  describe '#nth_to_the_last_improved' do
    let(:s1) { LinkedLists::SinglyLinkedNode.new(2) }
    let(:s2) { LinkedLists::SinglyLinkedNode.new(3, s1) }
    let(:s3) { LinkedLists::SinglyLinkedNode.new(1, s2) }

    it 'returns the value of the nth element to the last' do
      expect(subject.nth_to_the_last_improved(s3, 2)).to eq(s2.value)
    end
  end

  describe '#reverse_linked_list' do
    let(:s1) { LinkedLists::SinglyLinkedNode.new(2) }
    let(:s2) { LinkedLists::SinglyLinkedNode.new(3, s1) }
    let(:s3) { LinkedLists::SinglyLinkedNode.new(1, s2) }

    before { subject.reverse_linked_list(s3) }

    it 'reverses linked list' do
      expect(s1.next_node).to eq(s2)
      expect(s2.next_node).to eq(s3)
      expect(s3.next_node).to be_nil
    end
  end

  describe '#remove_duplicate' do
    let(:s1) { LinkedLists::SinglyLinkedNode.new(2) }
    let(:s2) { LinkedLists::SinglyLinkedNode.new(3, s1) }
    let(:s3) { LinkedLists::SinglyLinkedNode.new(1, s2) }
    let(:s4) { LinkedLists::SinglyLinkedNode.new(2, s3) }
    let(:s5) { LinkedLists::SinglyLinkedNode.new(1, s4) }

    before { subject.remove_duplicate(s5) }

    it 'removes the duplicates' do
      expect(s5.next_node).to eq(s4)
      expect(s4.next_node).to eq(s2)
      expect(s2.next_node).to be_nil
    end
  end

  describe '#remove_duplicate_without_buffer' do
    let(:s1) { LinkedLists::SinglyLinkedNode.new(2) }
    let(:s2) { LinkedLists::SinglyLinkedNode.new(3, s1) }
    let(:s3) { LinkedLists::SinglyLinkedNode.new(1, s2) }
    let(:s4) { LinkedLists::SinglyLinkedNode.new(2, s3) }
    let(:s5) { LinkedLists::SinglyLinkedNode.new(1, s4) }

    before { subject.remove_duplicate(s5) }

    it 'removes the duplicates' do
      expect(s5.next_node).to eq(s4)
      expect(s4.next_node).to eq(s2)
      expect(s2.next_node).to be_nil
    end
  end

  describe '#palindrome?' do
    let(:s1) { LinkedLists::SinglyLinkedNode.new(1) }
    let(:s2) { LinkedLists::SinglyLinkedNode.new(2, s1) }
    let(:s3) { LinkedLists::SinglyLinkedNode.new(3, s2) }
    let(:s4) { LinkedLists::SinglyLinkedNode.new(2, s3) }
    let(:s5) { LinkedLists::SinglyLinkedNode.new(1, s4) }

    it 'returns true if palindrome' do
      expect(subject.palindrome?(s5)).to be_truthy
    end

    it 'returns false if not palindrome' do
      s5.value = 2
      expect(subject.palindrome?(s5)).to be_falsey
    end
  end

  describe '#find_intersection' do
    let(:s1) { LinkedLists::SinglyLinkedNode.new(1) }
    let(:s2) { LinkedLists::SinglyLinkedNode.new(2, s1) }
    let(:s3) { LinkedLists::SinglyLinkedNode.new(3, s2) }
    let(:s4) { LinkedLists::SinglyLinkedNode.new(4, s3) }

    let(:s5) { LinkedLists::SinglyLinkedNode.new(5) }
    let(:s6) { LinkedLists::SinglyLinkedNode.new(6, s5) }
    let(:s7) { LinkedLists::SinglyLinkedNode.new(7, s6) }
    let(:s8) { LinkedLists::SinglyLinkedNode.new(8, s7) }
    let(:s9) { LinkedLists::SinglyLinkedNode.new(9, s8) }

    it 'returns nil if no intersection' do
      expect(subject.find_intersection(s4, s9)).to be_nil
    end

    it 'returns the node at the intersection' do
      s6.next_node = s2
      expect(subject.find_intersection(s4, s9)).to eq(s2)
    end
  end

  describe '#insert_node' do
    let(:d1) { LinkedLists::DoublyLinkedNode.new(7) }
    let(:d2) { LinkedLists::DoublyLinkedNode.new(5, nil, d1) }
    let(:d3) { LinkedLists::DoublyLinkedNode.new(3, nil, d2) }

    before do
      d1.prev_node = d2
      d2.prev_node = d3
      subject.insert_node(d3, 6)
    end

    it 'inserts the node at the right place' do
      expect(d2.next_node.value).to eq 6
      expect(d1.prev_node.value).to eq 6
    end
  end
end
