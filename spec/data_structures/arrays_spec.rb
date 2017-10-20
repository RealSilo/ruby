require_relative '../../lib/data_structures/arrays'
require 'byebug'

describe Arrays do
  subject { described_class.new }

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

      it 'returns the missing element' do
        expect(subject.find_missing(array1, array2)).to eq 5
      end
    end

    context 'with duplication' do
      let(:array1) { [1, 2, 3, 4, 5, 5] }
      let(:array2) { [4, 3, 1, 5, 2] }

      it 'returns the missing element' do
        expect(subject.find_missing(array1, array2)).to eq 5
      end
    end
  end

  describe '#largest_cont_sum' do
    context 'without positive and negative elements' do
      let(:array) { [1, 2, -1, 3, 4, 10, 10, -10, -1] }

      it 'returns the largest const sum' do
        expect(subject.largest_cont_sum(array)).to eq 29
      end
    end

    context 'with only negative elements' do
      let(:array) { [-1, -2, -1, -10, -1] }

      it 'returns 0' do
        expect(subject.largest_cont_sum(array)).to eq 0
      end
    end
  end

  describe '#sentence_reversal' do
    context 'without leading and trailing whitespaces' do
      let(:string) { 'Haha hihi huhu5' }

      it 'returns the reversed sentence' do
        expect(subject.sentence_reversal(string)).to eq 'huhu5 hihi Haha'
      end
    end

    context 'with leading and trailing whitespaces' do
      let(:string) { '  Haha hihi huhu5  ' }

      it 'returns the reversed sentence' do
        expect(subject.sentence_reversal(string)).to eq 'huhu5 hihi Haha'
      end
    end
  end

  describe '#string_compression' do
    context 'with non-repeating char at the beginning and the end' do
      let(:string) { 'gAABBccccd' }

      it 'returns the compressed string' do
        expect(subject.string_compression(string)).to eq 'g1A2B2c4d1'
      end
    end

    context 'with repeating char at the beginning and the end' do
      let(:string) { 'AABBcccc' }

      it 'returns the compressed string' do
        expect(subject.string_compression(string)).to eq 'A2B2c4'
      end
    end
  end

  describe '#parse_string' do
    let(:string) { ' 12 + 5 6 + 77' }

    it 'returns the parsed string' do
      expect(subject.parse_string(string)).to eq ['12', '+', '5', '6', '+', '77']
    end
  end

  describe '#number_of_trailing_zeros_of_factorial' do
    context 'when number is less than 1' do
      let(:number) { 0 }

      it 'returns 0' do
        expect(subject.number_of_trailing_zeros_of_factorial(number)).to eq 0
      end
    end

    context 'when number is more than 1' do
      let(:number) { 5 }

      it 'returns the number of 0-s at the end of the factorial' do
        expect(subject.number_of_trailing_zeros_of_factorial(number)).to eq 1
      end
    end
  end

  describe '#palindrome_without_recursion?' do
    context 'when the string is empty' do
      let(:string) { '' }

      it 'returns true' do
        expect(subject.palindrome_without_recursion?(string)).to be_truthy
      end
    end

    context 'when the string is a palindrome' do
      let(:string) { ' abcd dcb a' }

      it 'returns true' do
        expect(subject.palindrome_without_recursion?(string)).to be_truthy
      end
    end

    context 'when the string is NOT a palindrome' do
      let(:string) { 'e abceed dcb a' }

      it 'returns false' do
        expect(subject.palindrome_without_recursion?(string)).to be_falsey
      end
    end
  end

  describe '#palindrome?' do
    context 'when the string is empty' do
      let(:string) { '' }

      it 'returns true' do
        expect(subject.palindrome?(string)).to be_truthy
      end
    end

    context 'when the string is a palindrome' do
      let(:string) { ' abcd dcb a' }

      it 'returns true' do
        expect(subject.palindrome?(string)).to be_truthy
      end
    end

    context 'when the string is NOT a palindrome' do
      let(:string) { 'e abceed dcb a' }

      it 'returns false' do
        expect(subject.palindrome?(string)).to be_falsey
      end
    end
  end

  describe '#urlify_inplace' do
    let(:string) { 'Mr John Smith  ' }
    let(:length) { 13 }

    it 'returns the urlified string' do
      expect(subject.urlify_inplace(string, length)).to eq('Mr%20John%20Smith')
    end
  end

  describe '#urlify' do
    let(:string) { 'Mr John Smith  ' }
    let(:length) { 13 }

    it 'returns the urlified string' do
      expect(subject.urlify(string, length)).to eq('Mr%20John%20Smith')
    end
  end

  describe '#urlify_backwards' do
    let(:string) { 'Mr John Smith             ' }
    let(:length) { 13 }

    it 'returns the urlified string' do
      expect(subject.urlify_backwards(string, length)).to eq('Mr%20John%20Smith')
    end
  end

  describe '#rotate' do
    let(:matrix) { [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]] }

    it 'returns the rotated matrix' do
      expect(subject.rotate(matrix)).to eq(
        [[4, 8, 12, 16], [3, 7, 11, 15], [2, 6, 10, 14], [1, 5, 9, 13]]
      )
    end
  end

  describe '#rotate_in_place' do
    let(:matrix) { [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]] }

    it 'returns the rotated matrix' do
      expect(subject.rotate_in_place(matrix)).to eq(
        [[4, 8, 12, 16], [3, 7, 11, 15], [2, 6, 10, 14], [1, 5, 9, 13]]
      )
    end
  end

  describe '#change_zeros' do
    let(:matrix) { [[1, 2, 3, 4], [5, 0, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]] }

    it 'returns the modified matrix' do
      expect(subject.change_zeros(matrix)).to eq(
        [[1, 0, 3, 4], [0, 0, 0, 0], [9, 0, 11, 12], [13, 0, 15, 16]]
      )
    end
  end

  describe '#first_non_repeated_char' do
    let(:string) { 'abcdabc' }

    it 'returns the parsed string' do
      expect(subject.first_non_repeated_char(string)).to eq('d')
    end
  end

  # describe '#permutations' do
  #   let(:string) { 'abc' }

  #   subject { described_class.new }

  #   it 'returns the parsed string' do
  #     expect(subject.permutations('', string)).to eq(
  #       ['abc', 'acb', 'bac', 'bca', 'cab', 'cba']
  #     )
  #   end
  # end

  describe '#remove_duplicates' do
    let(:string) { 'ababcccddabdc' }

    it 'returns the parsed string' do
      expect(subject.remove_duplicates(string)).to eq('abcd')
    end
  end

  describe '#shuffle_of_two_strings?' do
    let(:string1) { 'abc' }
    let(:string2) { 'def' }

    context 'if shuffle' do
      let(:string3) { 'adefbc' }

      it 'returns true' do
        expect(subject.shuffle_of_two_strings?(string1, string2, string3)).to be_truthy
      end
    end

    context 'if not shuffle' do
      let(:string3) { 'adefcb' }

      it 'returns false' do
        expect(subject.shuffle_of_two_strings?(string1, string2, string3)).to be_falsey
      end
    end
  end

  describe '#substring_of_string' do
    let(:string1) { 'abcmmmamadef' }

    context 'if substring' do
      let(:string2) { 'mama' }

      it 'returns the starting index' do
        expect(subject.substring_of_string(string1, string2)).to eq 5
      end
    end

    context 'if substring' do
      let(:string2) { 'def' }

      it 'returns the starting index' do
        expect(subject.substring_of_string(string1, string2)).to eq 9
      end
    end

    context 'if not shuffle' do
      let(:string2) { 'haha' }

      it 'returns false' do
        expect(subject.substring_of_string(string1, string2)).to be_falsey
      end
    end
  end

  describe '#reverse_vowels' do
    context 'if vowels are next to each other' do
      let(:string) { 'friends' }

      it 'returns the starting index' do
        expect(subject.reverse_vowels(string)).to eq 'freinds'
      end
    end

    context 'if last char is vowel' do
      let(:string) { 'apple' }

      it 'returns the starting index' do
        expect(subject.reverse_vowels(string)).to eq 'eppla'
      end
    end
  end

  describe '#my_split' do
    let(:string) { '  5 + 11 + 4 ' }

    it 'returns the split array' do
      expect(subject.my_split(string, ' ')).to eq ['5', '+', '11', '+', '4']
    end
  end

  describe '#my_flatten' do
    let(:array) { [[3, 4], 5, [[4, 8], 9], 10] }

    it 'returns the flattened array' do
      expect(subject.my_flatten(array)).to eq [3, 4, 5, 4, 8, 9, 10]
    end
  end


  describe '#perm_of_palin?' do
    context 'if permutation of palindrome' do
      it 'returns true' do
        string = 'ciivc'
        expect(subject.perm_of_palin?(string)).to eq true
      end

      it 'returns true' do
        string = 'civic'
        expect(subject.perm_of_palin?(string)).to eq true
      end
    end

    context 'if not permutation of palindrome' do
      it 'returns false' do
        string = 'ciivca'
        expect(subject.perm_of_palin?(string)).to eq false
      end

      it 'returns false' do
        string = 'ccca'
        expect(subject.perm_of_palin?(string)).to eq false
      end
    end
  end
end
