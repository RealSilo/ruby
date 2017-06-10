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

  end
end
