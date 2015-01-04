module Quicksort
  
  # In this implementation, we're going for conciseness rather than efficiency
  # (i.e. we're not going to worry about wasteful intermediate allocations)
  
  def self.sort(ary)
    return ary if ary.length <= 1
    mid = ary.length / 2
    lte, gt = [], []
    
    ary.each_with_index do |e, i|
      next if i == mid
      if e <= ary[mid]
        lte << e
      else
        gt << e
      end
    end
    
    [*sort(lte), ary[mid], *sort(gt)]
  end

end