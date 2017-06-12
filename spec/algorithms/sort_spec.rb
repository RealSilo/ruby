require_relative '../../lib/algorithms/sort'
require 'byebug'

describe Sort do
  let(:array) { [10, 6, 1, 8, 1, 11] }
  subject { Sort.new }

  describe '#bubble_sort' do
    it 'returns the sorted collection' do
      expect(subject.bubble_sort(array)).to eq array.sort
    end
  end

  describe '#bubble_sort_2' do
    it 'returns the sorted collection' do
      expect(subject.bubble_sort_2(array)).to eq array.sort
    end
  end

  describe '#merge_sort' do
    let(:array) { [3, 5, 2, 10, 8] }

    it 'returns the sorted collection' do
      expect(subject.merge_sort(array)).to eq array.sort
    end

    describe '#merge' do
      let(:array1) { [1, 3, 7, 7] }
      let(:array2) { [2, 3, 3, 6] }

      it 'returns the sorted merged array' do
        expect(subject.merge(array1, array2)).to eq((array1 + array2).sort)
      end
    end
  end

  describe '#quick_sort' do
    let(:array) { [3, 5, 2, 10, 8, 1] }

    it 'returns the sorted collection' do
      expect(subject.quick_sort(array)).to eq [1, 2, 3, 5, 8, 10]
    end
  end

  describe '#quick_sort_2' do
    let(:array) { [3, 5, 2, 10, 8, 1] }

    it 'returns the sorted collection' do
      expect(subject.quick_sort_2(array)).to eq [1, 2, 3, 5, 8, 10]
    end
  end
end
