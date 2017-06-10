require_relative '../../lib/algorithms/search'
require 'byebug'

describe Search do
  subject { Search.new }

  describe 'sequential search' do
    context 'if the collection is unordered' do
      context 'if the value is found' do
        let(:array) { [1, 2, 3, 4, 5, 6, 7, 8] }
        let(:value) { 7 }

        it 'returns the position of the element' do
          expect(subject.unsorted_sequential_search(array, value)).to eq 6
        end
      end

      context 'if the value is not found' do
        let(:array) { [1, 2, 3, 4, 5, 6, 8] }
        let(:value) { 7 }

        it 'returns false' do
          expect(subject.unsorted_sequential_search(array, value)).to be_falsey
        end
      end
    end

    context 'if the collection is ordered' do
      context 'if the value is found' do
        let(:array) { [1, 2, 3, 4, 5, 6, 7, 8] }
        let(:value) { 7 }

        it 'returns the position of the element' do
          expect(subject.unsorted_sequential_search(array, value)).to eq 6
        end
      end

      context 'if the value is not found' do
        let(:array) { [1, 2, 3, 4, 5, 6, 8] }
        let(:value) { 7 }

        it 'returns false' do
          expect(subject.unsorted_sequential_search(array, value)).to be_falsey
        end
      end
    end
  end

  describe '#binary_search' do
    it 'returns the index if can be found' do
      expect(subject.binary_search([10, 20, 30, 40, 50], 50)).to eq(4)
    end

    it 'returns the error message if value not in array' do
      expect(subject.binary_search([10, 20, 30, 40, 50], 60)).to be_falsey
    end
  end

  describe '#binary_search_with_while' do
    it 'returns the index if can be found' do
      expect(subject.binary_search_with_while([10, 20, 30, 40, 50], 50)).to eq(4)
    end

    it 'returns the error message if value not in array' do
      expect(subject.binary_search_with_while([10, 20, 30, 40, 50], 60)).to be_falsey
    end
  end
end
