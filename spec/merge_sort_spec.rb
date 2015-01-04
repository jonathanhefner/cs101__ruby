$:<< File.dirname(__FILE__) << "#{File.dirname(__FILE__)}/.."
require 'merge_sort'
require 'rspec'

describe MergeSort do
  
  describe '#merge' do
    it 'merges in-order inputs' do
      expect(MergeSort.merge([1, 2], [3, 4])).to eq([1, 2, 3, 4])
    end
    
    it 'merges interleaved inputs' do
      expect(MergeSort.merge([1, 3], [2, 4])).to eq([1, 2, 3, 4])
    end
    
    it 'merges out-of-order inputs' do
      expect(MergeSort.merge([2, 3], [1, 4])).to eq([1, 2, 3, 4])
    end
    
    it 'merges left-heavy inputs' do
      expect(MergeSort.merge([1, 3, 5], [2, 4])).to eq([1, 2, 3, 4, 5])
    end
    
    it 'merges right-heavy inputs' do
      expect(MergeSort.merge([1, 3], [2, 4, 5])).to eq([1, 2, 3, 4, 5])
    end
    
    it 'merges duplicate elements' do
      expect(MergeSort.merge([1, 3, 5], [2, 3, 4])).to eq([1, 2, 3, 3, 4, 5])
    end
  end


  describe '#sort' do
    it 'sorts an even number of elements' do
      expect(MergeSort.sort([4, 3, 2, 1])).to eq([1, 2, 3, 4])
    end
    
    it 'sorts an odd number of elements' do
      expect(MergeSort.sort([5, 4, 3, 2, 1])).to eq([1, 2, 3, 4, 5])
    end
    
    it 'sorts duplicate elements' do
      expect(MergeSort.sort([4, 3, 1, 3, 2])).to eq([1, 2, 3, 3, 4])
    end
    
    it 'works on an empty list' do
      expect(MergeSort.sort([])).to eq([])
    end
    
    it 'works on a 1-element list' do
      expect(MergeSort.sort([1])).to eq([1])
    end
    
    it 'works on an already sorted array' do
      expect(MergeSort.sort([1, 2, 3])).to eq([1, 2, 3])
    end
  end
  
end
