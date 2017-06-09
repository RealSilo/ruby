require_relative '../../lib/data_structures/arrays'
require 'byebug'

describe Arrays do
  describe 'dynamic array' do
    let(:dynamic_array) { Arrays::DynamicArray.new(1) }

    before do
      5.times { |i| dynamic_array.push(i) }
    end

    it 'contains 5 elements' do
      expect(dynamic_array.length).to eq 5
    end

    it 'has a capacity of 8' do
      expect(dynamic_array.capacity).to eq 8
    end

    it 'has 0 as first element' do
      expect(dynamic_array[0]).to eq 0
    end
  end

  describe '#anagram' do
    subject { described_class.new }

    context 'when the 2 strings are anagrams' do
      let(:string1) { 'a R a' }
      let(:string2) { 'RAA' }

      it 'returns true' do
        expect(subject.anagram(string1, string2)).to be_truthy
      end
    end

    context 'when the 2 strings are not anagrams' do
      let(:string1) { 'B a R a' }
      let(:string2) { 'RAA' }

      it 'returns false' do
        expect(subject.anagram(string1, string2)).to be_falsey
      end
    end
  end

  describe '#sorted_array_pair_sum' do
    subject { described_class.new }

    context 'when there is a sum of pai that equals the number' do
      let(:array) { [1, 2, 4, 4] }
      let(:number) { 8 }

      it 'returns true' do
        expect(subject.sorted_array_pair_sum(array, number)).to be_truthy
      end
    end

    context 'when there is no sum of pair that equals the number' do
      let(:array) { [1, 2, 4, 5] }
      let(:number) { 8 }

      it 'returns false' do
        expect(subject.sorted_array_pair_sum(array, number)).to be_falsey
      end
    end

    context 'when the array is empty' do
      let(:array) { [] }
      let(:number) { 8 }

      it 'returns false' do
        expect(subject.unsorted_array_pair_sum(array, number)).to be_falsey
      end
    end

    context 'when the array has 1 element' do
      let(:array) { [8] }
      let(:number) { 8 }

      it 'returns false' do
        expect(subject.unsorted_array_pair_sum(array, number)).to be_falsey
      end
    end
  end

  describe '#unsorted_array_pair_sum' do
    subject { described_class.new }

    context 'when there is a sum of pai that equals the number' do
      let(:array) { [4, 2, 1, 4] }
      let(:number) { 8 }

      it 'returns true' do
        expect(subject.unsorted_array_pair_sum(array, number)).to be_truthy
      end
    end

    context 'when there is no sum of pair that equals the number' do
      let(:array) { [5, 2, 4, 1] }
      let(:number) { 8 }

      it 'returns false' do
        expect(subject.unsorted_array_pair_sum(array, number)).to be_falsey
      end
    end

    context 'when the array is empty' do
      let(:array) { [] }
      let(:number) { 8 }

      it 'returns false' do
        expect(subject.unsorted_array_pair_sum(array, number)).to be_falsey
      end
    end

    context 'with the array has 1 element' do
      let(:array) { [8] }
      let(:number) { 8 }

      it 'returns false' do
        expect(subject.unsorted_array_pair_sum(array, number)).to be_falsey
      end
    end
  end

  describe '#find_missing' do
    context 'without duplication' do
      let(:array1) { [1, 2, 3, 4, 5, 6] }
      let(:array2) { [4, 3, 1, 6, 2] }

      subject { described_class.new }

      it 'returns the missing element' do
        expect(subject.find_missing(array1, array2)).to eq 5
      end
    end

    context 'with duplication' do
      let(:array1) { [1, 2, 3, 4, 5, 5] }
      let(:array2) { [4, 3, 1, 5, 2] }

      subject { described_class.new }

      it 'returns the missing element' do
        expect(subject.find_missing(array1, array2)).to eq 5
      end
    end
  end

  describe '#largest_cont_sum' do
    context 'without positive and negative elements' do
      let(:array) { [1, 2, -1, 3, 4, 10, 10, -10, -1] }

      subject { described_class.new }

      it 'returns the largest const sum' do
        expect(subject.largest_cont_sum(array)).to eq 29
      end
    end

    context 'with only negative elements' do
      let(:array) { [-1, -2, -1, -10, -1] }

      subject { described_class.new }

      it 'returns 0' do
        expect(subject.largest_cont_sum(array)).to eq 0
      end
    end
  end
end