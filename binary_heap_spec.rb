require './binary_heap.rb'
require 'rspec'

describe BinaryHeap do

  let(:heap) {
    nums.inject(described_class.new(min_heap)){|h, n| h.insert(n) }
  }
  
  context 'using example data' do
    let(:nums) { [23, 19, 3, 5, 13, 17, 2, 1, 11, 7, 29] }
    let(:take_all) {
      a = []
      a << heap.take while heap.peek
      a
    }
    
    context 'as a max heap' do
      let(:min_heap) { false }
      
      it 'dequeues the values in the correct order' do
        take_all.should == nums.sort.reverse
      end
    end
    
    context 'as a min heap' do
      let(:min_heap) { true }
    
      it 'dequeues the values in the correct order' do
        take_all.should == nums.sort
      end
    end
    
  end
  
end
