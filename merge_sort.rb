module MergeSort
  
  # In this implementation, we're going for conciseness rather than efficiency
  # (i.e. we're not going to worry about wasteful intermediate allocations)
  
  def self.sort(ary)
    return ary if ary.length <= 1
    mid = ary.length / 2
    merge(sort(ary[0...mid]), sort(ary[mid..-1]))
  end
  
  def self.merge(ary1, ary2)
    ary = []
    i1, i2 = 0, 0
    
    while i1 < ary1.length || i2 < ary2.length
      if i1 < ary1.length && (i2 >= ary2.length || ary1[i1] <= ary2[i2])
        ary << ary1[i1]
        i1 += 1
      else
        ary << ary2[i2]
        i2 += 1
      end
    end
    
    ary
  end

end