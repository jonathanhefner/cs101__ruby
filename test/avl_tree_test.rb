require_relative "test_helper"
require "avl_tree"


class AvlTreeTest < Minitest::Test

  VALS = [23, 19, 3, 5, 13, 17, 2, 1, 11, 7, 29]
  #         13
  #       /    \
  #      3      19
  #     / \    /  \
  #    2   7  17  23
  #   /   / \       \
  #  1   5  11      29

  def make_tree(vals)
    vals.reduce(AvlTree.new(vals.first)){|t, v| t.insert(v) }
  end

  def assert_invariants(vals, tree)
    assert_equal Math.log2(vals.length).floor, tree.height, "height"

    assert_equal vals.max, tree.max, "max"
    assert_equal vals.min, tree.min, "min"

    assert_operator(tree.val, :>, tree.left.max, "left values") if tree.left
    assert_operator(tree.val, :<, tree.right.min, "right values") if tree.right

    assert_equal vals.sort, tree.in_order, "in_order traversal"

    assert_equal vals.sort, tree.breadth_first.sort, "breadth_first elements"
    assert_equal tree.val, tree.breadth_first.first, "breadth_first first"

    assert_equal vals.sort, tree.pre_order.sort, "pre_order elements"
    assert_equal tree.val, tree.pre_order.first, "pre_order first"

    assert_equal vals.sort, tree.post_order.sort, "post_order elements"
    assert_equal tree.val, tree.post_order.last, "post_order last"
  end

  def assert_invariants_recursively(vals, tree)
    return if vals.empty?
    assert_invariants(vals, tree)
    assert_invariants_recursively(vals.select{|v| v < tree.val }, tree.left)
    assert_invariants_recursively(vals.select{|v| v > tree.val }, tree.right)
  end

  def test_typical_tree
    assert_invariants_recursively VALS, make_tree(VALS)
  end

  def test_duplicate_inserts
    assert_invariants_recursively VALS, make_tree(VALS * 2)
  end

  def test_delete_any_node
    VALS.each do |v|
      vals = VALS - [v]
      tree = make_tree(VALS).delete(v)
      assert_invariants_recursively vals, tree
    end
  end

  def test_delete_only_node
    tree = make_tree([7])
    assert_nil tree.delete(7)
  end

  def test_delete_nonexistant_node
    assert_invariants_recursively VALS, make_tree(VALS).delete(VALS.max + 1)
  end

end
