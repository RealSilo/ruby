require_relative '../../lib/algorithms/dynamic'
require 'byebug'

describe Dynamic do
  subject { Dynamic.new }

  describe 'possible_set_of_coins_for_sum' do
    let(:coins) { [1, 5, 10] }
    let(:amount) { 22 }

    it 'returns the number of the possible sums'
  end
end
