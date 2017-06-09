require_relative '../../lib/data_structures/stacks_queues'
require 'byebug'

describe StacksQueues do
  subject { described_class.new }

  describe '#balanced_parantheses?' do
    context 'when the parantheses are balanced' do
      let(:string) { '()(){[(){}]}' }

      it 'returns true' do
        expect(subject.balanced_parantheses?(string)).to be_truthy
      end
    end

    context 'when the parantheses are NOT balanced' do
      let(:string) { '()(){[(){}]}}{' }

      it 'returns false' do
        expect(subject.balanced_parantheses?(string)).to be_falsey
      end
    end
  end

  describe StacksQueues::QueueWithTwoStacks do
    subject { described_class.new }

    before do
      subject.enqueue(1)
      subject.enqueue(2)
      subject.enqueue(3)
    end

    it 'behaves like FIFO when the element is dequeued' do
      expect(subject.dequeue).to eq 1
    end

    it 'behaves like FIFO when the element is dequeued' do
      subject.dequeue
      subject.enqueue(4)
      expect(subject.dequeue).to eq 2
    end
  end
end
