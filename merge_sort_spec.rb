require './merge_sort.rb'
require 'rspec'

describe MergeSort do
  
  describe '#merge' do
    it 'merges in-order inputs' do
      MergeSort.merge([1, 2], [3, 4]).should == [1, 2, 3, 4]
    end
    
    it 'merges interleaved inputs' do
      MergeSort.merge([1, 3], [2, 4]).should == [1, 2, 3, 4]
    end
    
    it 'merges out-of-order inputs' do
      MergeSort.merge([2, 3], [1, 4]).should == [1, 2, 3, 4]
    end
    
    it 'merges left-heavy inputs' do
      MergeSort.merge([1, 3, 5], [2, 4]).should == [1, 2, 3, 4, 5]
    end
    
    it 'merges right-heavy inputs' do
      MergeSort.merge([1, 3], [2, 4, 5]).should == [1, 2, 3, 4, 5]
    end
    
    it 'merges duplicate elements' do
      MergeSort.merge([1, 3, 5], [2, 3, 4]).should == [1, 2, 3, 3, 4, 5]
    end
  end


  describe '#sort' do
    it 'sorts an even number of elements' do
      MergeSort.sort([4, 3, 2, 1]).should == [1, 2, 3, 4]
    end
    
    it 'sorts an odd number of elements' do
      MergeSort.sort([5, 4, 3, 2, 1]).should == [1, 2, 3, 4, 5]
    end
    
    it 'sorts duplicate elements' do
      MergeSort.sort([4, 3, 1, 3, 2]).should == [1, 2, 3, 3, 4]
    end
    
    it 'works on an empty list' do
      MergeSort.sort([]).should == []
    end
    
    it 'works on a 1-element list' do
      MergeSort.sort([1]).should == [1]
    end
    
    it 'works on an already sorted array' do
      MergeSort.sort([1, 2, 3]).should == [1, 2, 3]
    end
  end
  
end
