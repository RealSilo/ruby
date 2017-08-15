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
end
