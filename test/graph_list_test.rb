require_relative "test_helper"
require "graph_list"


class GraphListTest < Minitest::Test

  # (all directed edges point downwards)
  #     a
  #   / | \
  #  b  c  d
  #  \ / \ /
  #   e   f
  #   |
  #   g
  ADJACENCIES = {
    a: [:b, :c, :d],
    b: [:e],
    c: [:e, :f],
    d: [:f],
    e: [:g],
    f: [],
    g: []
  }

  def make_model(adjacencies, directed)
    model = adjacencies.keys.reduce({}){|m, v| m.merge(v => {}) }

    adjacencies.each do |v1, v2s|
      v2s.each do |v2|
        model[v1][v2] = true
        model[v2][v1] = true if !directed
      end
    end

    model
  end

  def model_delete_node(model, node)
    model.delete(node)
    model.each{|v1, v2s| v2s.delete(node) }
  end

  def model_delete_edge(model, v1, v2, directed)
    model[v1].delete(v2)
    model[v2].delete(v1) if !directed
  end

  def make_graph(adjacencies, directed)
    graph = GraphList.new(directed)

    adjacencies.keys.each{|v| graph.add_node(v) }
    adjacencies.each do |v1, v2s|
      v2s.each{|v2| graph.add_edge(v1, v2) }
    end

    graph
  end

  def assert_depth_first_traversal(model, start, traversal)
    path = [start]
    traversal[1..-1].each do |current|
      parent = path.rindex{|v| model[v][current] }
      refute_nil parent, "Parent of #{current} is not in #{path.inspect}"
      path = path[0..parent]
      path << current
    end
  end

  # SIDENOTE: it would be nice if Array#index offered this by default
  # via an optional parameter
  def index_starting_at(array, start_at, &block)
    index = start_at
    index += 1 while index < array.length && !block.call(array[index])
    index < array.length ? index : nil
  end

  def assert_breadth_first_traversal(model, start, traversal)
    parent = 0
    traversal[1..-1].each do |current|
      parent = index_starting_at(traversal, parent){|v| model[v][current] }
      refute_nil parent, "Parent of #{current} is out-of-order or non-existent in #{traversal.inspect}"
    end
  end

  def assert_invariants(model, graph)
    model.keys.each do |node|
      assert_breadth_first_traversal model, node, graph.breadth_first(node)

      assert_depth_first_traversal model, node, graph.depth_first(node)

      successors = model[node].select{|v, connected| connected }.keys
      assert_equal successors.sort, graph.successors(node).sort
    end
  end

  def for_each_node_in_each_scenario(&block)
    [true, false].each do |directed|
      ADJACENCIES.keys.each do |node|
        model = make_model(ADJACENCIES, directed)
        graph = make_graph(ADJACENCIES, directed)
        block.call(node, directed, model, graph)
      end
    end
  end


  def test_directed_graph
    model = make_model(ADJACENCIES, true)
    graph = make_graph(ADJACENCIES, true)
    assert_invariants model, graph
  end

  def test_undirected_graph
    model = make_model(ADJACENCIES, false)
    graph = make_graph(ADJACENCIES, false)
    assert_invariants model, graph
  end

  def test_delete_node
    for_each_node_in_each_scenario do |node, directed, model, graph|
      model_delete_node(model, node)
      graph.delete_node(node)
      assert_invariants model, graph
    end
  end

  def test_delete_edge
    for_each_node_in_each_scenario do |node, directed, model, graph|
      other = model[node].select{|v2, connected| connected }.keys.first

      if other
        model_delete_edge(model, node, other, directed)
        graph.delete_edge(node, other)
        assert_invariants model, graph
      end
    end
  end

end
