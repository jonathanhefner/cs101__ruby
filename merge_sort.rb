module MergeSort
  
  # In this implementation, we're going for conciseness rather than efficiency
  # (i.e. we're not going to worry about wasteful intermediate allocations)
  
  def self.sort(ary)
    return ary if ary.length <= 1
    mid = ary.length / 2
    merge(sort(ary[0...mid]), sort(ary[mid..-1]))
  end
  
  def self.merge(ary1, ary2)
    return ary1 if ary2.empty?
    return ary2 if ary1.empty?
    
    if ary1.first <= ary2.first
      [ary1.first, *merge(ary1[1..-1], ary2)]
    else
      [ary2.first, *merge(ary1, ary2[1..-1])]
    end
  end

end