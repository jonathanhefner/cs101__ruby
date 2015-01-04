$:<< File.dirname(__FILE__) << "#{File.dirname(__FILE__)}/.."
require 'quicksort'
require 'rspec'

describe Quicksort do

  describe '#sort' do
    it 'sorts an even number of elements' do
      Quicksort.sort([4, 3, 2, 1]).should == [1, 2, 3, 4]
    end
    
    it 'sorts an odd number of elements' do
      Quicksort.sort([5, 4, 3, 2, 1]).should == [1, 2, 3, 4, 5]
    end
    
    it 'sorts duplicate elements' do
      Quicksort.sort([4, 3, 1, 3, 2]).should == [1, 2, 3, 3, 4]
    end
    
    it 'works on an empty list' do
      Quicksort.sort([]).should == []
    end
    
    it 'works on a 1-element list' do
      Quicksort.sort([1]).should == [1]
    end
    
    it 'works on an already sorted array' do
      Quicksort.sort([1, 2, 3]).should == [1, 2, 3]
    end
  end
  
end
