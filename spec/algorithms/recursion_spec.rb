require_relative '../../lib/algorithms/recursion'
require 'byebug'

describe Recursion do
  subject { Recursion.new }

  describe '#factorial' do
    it 'returns the product of the integers from 1 to n' do
      expect(subject.factorial(4)).to eq 24
    end
  end

  describe '#cumulative_sum' do
    it 'returns the sum of the integers from 0 to n' do
      expect(subject.cumulative_sum(4)).to eq 10
    end
  end

  describe '#sum_digits' do
    it 'returns the sum of the digits from 0 to n' do
      expect(subject.sum_digits(4321)).to eq 10
    end
  end

  describe '#sum_digits_with_modulo' do
    it 'returns the sum of the digits from 0 to n' do
      expect(subject.sum_digits(4321)).to eq 10
    end
  end

  describe '#phrase_split' do
    it 'if the phrase can be made from the combination of the words' do
      expect(subject.phrase_split('rantheman', %w[man the ran])).to be_truthy
    end

    it 'if the phrase can NOT be made from the combination of the words' do
      expect(subject.phrase_split('deal', %w[man the ran])).to be_falsey
    end
  end

  describe '#recursive_reverse' do
    it 'it reverses the string' do
      expect(subject.recursive_reverse('hahaha')).to eq 'ahahah'
    end
  end

  # describe '#string_permutation' do
  #   it 'it returns all the combinations' do
  #     expect(subject.string_permutation('abc')).to eq ['abc', 'acb', 'bac', 'bca', 'cab', 'cba']
  #   end
  # end

  describe '#fibonacci' do
    it 'it returns the number on the nth place' do
      expect(subject.fibonacci(10)).to eq 55
    end
  end

  describe '#fibonacci_with_memo' do
    it 'it returns the number on the nth place' do
      expect(subject.fibonacci_with_memo(10)).to eq 55
    end
  end

  describe '#fibonacci_with_memo_detailed' do
    it 'it returns the number on the nth place' do
      expect(subject.fibonacci_with_memo_detailed(10)).to eq 55
    end
  end

  describe '#fibonacci_iteratively' do
    it 'it returns the number on the nth place' do
      expect(subject.fibonacci_iteratively(10)).to eq 55
    end
  end

  describe '#fibonacci_iteratively_2' do
    it 'it returns the number on the nth place' do
      expect(subject.fibonacci_iteratively_2(10)).to eq 55
    end
  end

  describe '#min_coin_number' do
    it 'it returns the min coin number' do
      expect(subject.min_coin_number(11, [1, 2, 5, 10])).to eq 2
    end
  end
end
