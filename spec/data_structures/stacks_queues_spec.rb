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

    context 'when the parantheses are NOT balanced' do
      let(:string) { '((' }

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

  describe StacksQueues::StackMin::Stack do
    subject { described_class.new }

    before do
      subject.push(4)
      subject.push(3)
      subject.push(5)
      subject.push(2)
      subject.pop
    end

    it 'returns the min value' do
      expect(subject.min).to eq 3
    end
  end

  describe StacksQueues::StackMin::Stack do
    subject { described_class.new }

    before do
      subject.push(4)
      subject.push(3)
      subject.push(5)
      subject.push(2)
      subject.pop
    end

    it 'returns the min value' do
      expect(subject.min).to eq 3
    end
  end

  describe StacksQueues::AnimalQueueProblem::AnimalQueue do
    subject { described_class.new }
    let(:dog) { StacksQueues::AnimalQueueProblem::Dog.new('Jack', 5) }
    let(:cat) { StacksQueues::AnimalQueueProblem::Cat.new('Jane', 3) }

    before do
      subject.enqueue(dog)
      subject.enqueue(cat)
    end

    it 'returns the dog' do
      expect(subject.dequeue_any).to eq(dog)
    end
  end
end
