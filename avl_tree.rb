class AvlTree < Struct.new(:val, :left, :right)

  def initialize(v)
    self.val = v
  end
  
  def height
    [left_height, right_height].max
  end
  
  def left_height
    left ? (left.height + 1) : 0
  end
  
  def right_height
    right ? (right.height + 1) : 0
  end
  
  def balance_factor
    right_height - left_height
  end
  
  def min
    return left.min if left
    return right.min if right
    val
  end
  
  def max
    return right.max if right
    return left.max if left
    val
  end

  # NOTE returns the new root/node to replace the current one
  def insert(new_val)
    return self if val == new_val # value already exists, abort
    lr = new_val < val ? :left : :right
    self[lr] = self[lr] ? self[lr].insert(new_val) : AvlTree.new(new_val)
    rebalance
  end
  
  # NOTE returns the new root/node to replace the current one
  def delete(del_val)
    if val == del_val # delete this node
      if left && right
        self.val = left.max    # ALT: self.val = right.min
        left.delete(self.val)  # ALT: right.delete(self.val)
        rebalance
      else
        left || right
      end
      
    else
      lr = del_val < val ? :left : :right
      self[lr] = self[lr].delete(del_val) if self[lr]
      rebalance
    end
  end
  
  # NOTE returns the new root/node to replace the current one
  def rebalance
    if balance_factor < -1 # Left-Left or Left-Right
      if left.balance_factor > 0 # Left-Right
        self.left = left.rotate_left
      end
      rotate_right
      
    elsif balance_factor > 1 # Right-Right or Right-Left
      if right.balance_factor < 0 # Right-Left
        self.right = right.rotate_right
      end
      rotate_left
      
    else
      self
    end
  end
  
  # NOTE returns the new root/node to replace the current one
  def rotate_left
    n = self.right
    self.right = n.left
    n.left = self
    n
  end
  
  # NOTE insert returns the new root/node to replace the current one
  def rotate_right
    n = self.left
    self.left = n.right
    n.right = self
    n
  end
  
  def pre_order(acc=[])
    acc << val
    left.pre_order(acc) if left
    right.pre_order(acc) if right
    acc
  end
    
  def in_order(acc=[])
    left.in_order(acc) if left
    acc << val
    right.in_order(acc) if right
    acc
  end
  
  def post_order(acc=[])
    left.post_order(acc) if left
    right.post_order(acc) if right
    acc << val
    acc
  end
  
  def breadth_first
    acc = []
    queue = [self]
    
    while queue.any?
      n = queue.shift
      acc << n.val
      queue.push(n.left) if n.left
      queue.push(n.right) if n.right
    end
    
    acc
  end
  
end
