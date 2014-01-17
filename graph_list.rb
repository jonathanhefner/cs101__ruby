class GraphList < Struct.new(:nodes, :directed)
  # implemented with adjacency lists (as opposed to an adjacency matrix)

  class DirectedEdge < Struct.new(:dest, :weight); end
  
  class Node < Struct.new(:val, :edges);
    def initialize(val)
      super(val, [])
    end
    
    def add_edge(dest, weight)
      self.edges << DirectedEdge.new(dest, weight)
    end
    
    def delete_edge(dest)
      self.edges.delete_if{|e| e.dest == dest }
    end
    
    def destinations
      edges.map(&:dest)
    end
  end
  
  
  def initialize(directed)
    super({}, directed)
  end
  
  def add_node(val)
    return if nodes.key?(val)
    nodes[val] = Node.new(val)
  end
  
  def delete_node(val)
    n = nodes.delete(val)
    return unless n
    nodes.values.each{|node| node.delete_edge(n) }
  end
  
  def add_edge(val1, val2, weight=1)
    n1, n2 = nodes[val1], nodes[val2]
    return unless n1 && n2
    n1.add_edge(n2, weight)
    n2.add_edge(n1, weight) unless directed
  end
  
  def delete_edge(val1, val2)
    n1, n2 = nodes[val1], nodes[val2]
    return unless n1 && n2
    n1.delete_edge(n2)
    n2.delete_edge(n1) unless directed
  end
  
  def successors(val)
    return unless nodes.key?(val)
    nodes[val].destinations.map(&:val)
  end
  
  def traverse(start, &dequeue)
    acc = []
    visited = {}
    queue = [nodes[start]]
    return if queue.first.nil?
    
    while queue.any?
      n = dequeue.call(queue)
      unless visited[n]
        acc << n.val
        visited[n] = true
        queue += n.destinations.reject{|d| visited[d] }
      end
    end
    
    acc
  end
  
  def depth_first(start)
    traverse(start){|queue| queue.pop }
  end
 
  def breadth_first(start)
    traverse(start){|queue| queue.shift }
  end
  
end
