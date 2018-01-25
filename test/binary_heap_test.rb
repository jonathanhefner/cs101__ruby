require_relative "test_helper"
require "binary_heap"


class BinaryHeapTest < Minitest::Test

  VALS = [23, 19, 3, 5, 13, 17, 2, 1, 11, 7, 29]

  def make_heap(ascending, vals)
    vals.reduce(BinaryHeap.new(ascending)){|h, v| h.insert(v) }
  end

  def take_all(heap)
    a = []
    a << heap.take while heap.peek
    a
  end

  def test_max_heap
    heap = make_heap(false, VALS)
    actual = take_all(heap)
    assert_equal VALS.sort.reverse, actual
  end

  def test_min_heap
    heap = make_heap(true, VALS)
    actual = take_all(heap)
    assert_equal VALS.sort, actual
  end

end
