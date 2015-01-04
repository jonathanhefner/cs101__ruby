class BinaryHeap < Struct.new(:nodes)

  def initialize(min_heap=false)
    super([])
    @mult = min_heap ? -1 : 1
  end

  def insert(val)
    nodes << val
    sift_up(nodes.length - 1)
    self
  end
  
  def take
    return unless nodes.any?
    return nodes.pop if nodes.one?
    val = nodes.first
    nodes[0] = nodes.pop
    sift_down(0)
    val
  end
  
  def peek
    nodes.first
  end
  
  def sift_down(i) # AKA max/min_heapify
    j = rootmost(rootmost(i, left(i)), right(i))
    unless j == i
      nodes[i], nodes[j] = nodes[j], nodes[i]
      sift_down(j)
    end
  end
  
  def sift_up(i) # AKA bubble_up
    p = parent(i)
    unless p < 0 || rootmost(p, i) == p
      nodes[i], nodes[p] = nodes[p], nodes[i]
      sift_up(p)
    end
  end
  
  def left(i)
    2 * i + 1
  end
  
  def right(i)
    2 * i + 2
  end
  
  def parent(i)
    (i - 1) / 2
  end
  
  def rootmost(i1, i2)
    # returns i1 or i2 based on which one's value *should* be closer to root
    return i1 if i2 >= nodes.length
    return i2 if i1 >= nodes.length
    ((nodes[i1] <=> nodes[i2]) * @mult) < 0 ? i2 : i1
  end
  
end
