require_relative '../../lib/data_structures/arrays'
require 'byebug'

describe Arrays do
  describe 'dynamic array' do
    let(:dynamic_array) { Arrays::DynamicArray.new(1) }

    before do
      5.times { dynamic_array.push(1) }
    end

    it 'contains 5 elements' do
      expect(dynamic_array.length).to eq 5
    end

    it 'has a capacity of 8' do
      expect(dynamic_array.capacity).to eq 8
    end
  end
end
