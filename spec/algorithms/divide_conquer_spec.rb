require_relative '../../lib/algorithms/divide_conquer'
require 'byebug'

describe DivideConquer do
  subject { DivideConquer.new }

  describe 'trade' do
    context 'when the price is fluctuating' do
      let(:prices) { [9, 22, 5, 10, 1, 16, 19] }

      it 'returns the largest difference for the trade' do
        expect(subject.trade(prices)).to eq 18
      end
    end

    context 'when the price only decreases' do
      let(:prices) { [49, 42, 35, 30, 20, 16, 9] }

      it 'returns the largest difference for the trade' do
        expect(subject.trade(prices)).to eq 0
      end
    end
  end
end
