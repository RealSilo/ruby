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

  describe '#sentence_reversal' do
    context 'without leading and trailing whitespaces' do
      let(:string) { 'Haha hihi huhu5' }

      subject { described_class.new }

      it 'returns the reversed sentence' do
        expect(subject.sentence_reversal(string)).to eq 'huhu5 hihi Haha'
      end
    end

    context 'with leading and trailing whitespaces' do
      let(:string) { '  Haha hihi huhu5  ' }

      subject { described_class.new }

      it 'returns the reversed sentence' do
        expect(subject.sentence_reversal(string)).to eq 'huhu5 hihi Haha'
      end
    end
  end

  describe '#string_compression' do
    context 'with non-repeating char at the beginning and the end' do
      let(:string) { 'gAABBccccd' }

      subject { described_class.new }

      it 'returns the compressed string' do
        expect(subject.string_compression(string)).to eq 'g1A2B2c4d1'
      end
    end

    context 'with repeating char at the beginning and the end' do
      let(:string) { 'AABBcccc' }

      subject { described_class.new }

      it 'returns the compressed string' do
        expect(subject.string_compression(string)).to eq 'A2B2c4'
      end
    end
  end

  describe '#parse_string' do
    let(:string) { ' 12 + 5 6 + 77' }

    subject { described_class.new }

    it 'returns the parsed string' do
      expect(subject.parse_string(string)).to eq ['12', '+', '5', '6', '+', '77']
    end
  end

  describe '#number_of_trailing_zeros_of_factorial' do
    context 'when number is less than 1' do
      let(:number) { 0 }

      subject { described_class.new }

      it 'returns 0' do
        expect(subject.number_of_trailing_zeros_of_factorial(number)).to eq 0
      end
    end

    context 'when number is more than 1' do
      let(:number) { 5 }

      subject { described_class.new }

      it 'returns the number of 0-s at the end of the factorial' do
        expect(subject.number_of_trailing_zeros_of_factorial(number)).to eq 1
      end
    end
  end
  
  describe '#palindrome_without_recursion?' do
    context 'when the string is empty' do
      let(:string) { '' }

      subject { described_class.new }

      it 'returns true' do
        expect(subject.palindrome_without_recursion?(string)).to be_truthy
      end
    end

    context 'when the string is a palindrome' do
      let(:string) { ' abcd dcb a' }

      subject { described_class.new }

      it 'returns true' do
        expect(subject.palindrome_without_recursion?(string)).to be_truthy
      end
    end

    context 'when the string is NOT a palindrome' do
      let(:string) { 'e abceed dcb a' }

      subject { described_class.new }

      it 'returns false' do
        expect(subject.palindrome_without_recursion?(string)).to be_falsey
      end
    end
  end

  describe '#palindrome?' do
    context 'when the string is empty' do
      let(:string) { '' }

      subject { described_class.new }

      it 'returns true' do
        expect(subject.palindrome?(string)).to be_truthy
      end
    end

    context 'when the string is a palindrome' do
      let(:string) { ' abcd dcb a' }

      subject { described_class.new }

      it 'returns true' do
        expect(subject.palindrome?(string)).to be_truthy
      end
    end

    context 'when the string is NOT a palindrome' do
      let(:string) { 'e abceed dcb a' }

      subject { described_class.new }

      it 'returns false' do
        expect(subject.palindrome?(string)).to be_falsey
      end
    end
  end
end
