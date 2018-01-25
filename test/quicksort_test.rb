require_relative "test_helper"
require "quicksort"


class QuicksortTest < Minitest::Test

  VALS = [1, 2, 4, 3, 2, 1, 3]

  def assert_invariants(vals, sorted)
    assert_equal vals.length, sorted.length

    assert_equal vals.group_by(&:itself), sorted.group_by(&:itself)

    (1...sorted.length).each do |i|
      assert_operator sorted[i - 1], :<=, sorted[i]
    end
  end

  def test_sort
    (0..VALS.length).each do |n|
      assert_invariants VALS.take(n), Quicksort.sort(VALS.take(n))
    end
  end

end
