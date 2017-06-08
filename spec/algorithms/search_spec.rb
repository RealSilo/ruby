require_relative '../../lib/algorithms/search'
require 'byebug'

describe Search do
  let(:search_instance) { Search.new }

  context '#binary_search' do
    it 'returns the index if can be found' do
      expect(search_instance.binary_search([10, 20, 30, 40, 50], 40)).to eq(3)
      expect(search_instance.binary_search([10, 20, 30, 40, 50], 10)).to eq(0)
    end

    it 'returns the error message if value not in array' do
      expect(search_instance.binary_search([10, 20, 30, 40, 50], 60)).to eq("Value not in array")
      expect(search_instance.binary_search([10, 20, 30, 40, 50], -5)).to eq("Value not in array")
    end
  end
end
