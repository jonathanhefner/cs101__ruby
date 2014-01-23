require './avl_tree.rb'
require 'rspec'

describe AvlTree do

  let(:tree) {
    nums.inject(nil){|t, n| t ? t.insert(n) : described_class.new(n) }
  }

  context 'with example data' do
    let(:nums) { [23, 19, 3, 5, 13, 17, 2, 1, 11, 7, 29] }
    #         13
    #       /    \
    #      3      19
    #     / \    /  \
    #    2   7  17  23
    #   /   / \       \
    #  1   5  11      29
    
    context 'root' do
      subject { tree }
      its(:val) { should == 13 }
      its(:min) { should == 1 }
      its(:max) { should == 29 }
      its(:height) { should == 3 }
      its(:left_height) { should == 3 }
      its(:right_height) { should == 3 }
      its(:balance_factor) { should == 0 }
      
      it 'should yield a correct in-order traversal' do
        tree.in_order.should == nums.sort
      end
      
      it 'should yield a correct pre-order traversal' do
        tree.pre_order.should == [13, 3, 2, 1, 7, 5, 11, 19, 17, 23, 29]
      end
      
      it 'should yield a correct post-order traversal' do
        tree.post_order.should == [1, 2, 5, 11, 7, 3, 17, 29, 23, 19, 13]
      end
      
      it 'should yield a correct breadth-first traversal' do
        tree.breadth_first.should == [13, 3, 19, 2, 7, 17, 23, 1, 5, 11, 29]
      end
    
      context '=> 3 => 2' do
        subject { tree.left.left }
        its(:val) { should == 2 }
        its(:min) { should == 1 }
        its(:max) { should == 2 }
        its(:height) { should == 1 }
        its(:left_height) { should == 1 }
        its(:right_height) { should == 0 }
        its(:balance_factor) { should == -1 }
        
        context '=> 1' do
          subject { tree.left.left.left }
          its(:val) { should == 1 }
          its(:min) { should == 1 }
          its(:max) { should == 1 }
          its(:height) { should == 0 }
          its(:left_height) { should == 0 }
          its(:right_height) { should == 0 }
          its(:balance_factor) { should == 0 }
        end
      end
      
      context '=> 19' do
        subject { tree.right }
        its(:val) { should == 19 }
        its(:min) { should == 17 }
        its(:max) { should == 29 }
        its(:height) { should == 2 }
        its(:left_height) { should == 1 }
        its(:right_height) { should == 2 }
        its(:balance_factor) { should == 1 }
        
        context '=> 23' do
          subject { tree.right.right }
          its(:val) { should == 23 }
          its(:min) { should == 23 }
          its(:max) { should == 29 }
          its(:height) { should == 1 }
          its(:left_height) { should == 0 }
          its(:right_height) { should == 1 }
          its(:balance_factor) { should == 1 }
        end
      end
    end
  end

  
  context 'with example duplicate data' do
    let(:nums) { [2, 1, 3] * 4 }
    #    2
    #   / \
    #  1   3
    
    subject { tree }
    its(:height) { should == 1 }
    its(:left_height) { should == 1 }
    its(:right_height) { should == 1 }
    its(:balance_factor) { should == 0 }  
  end
  
  
  describe '#delete' do
    context 'when removing a leaf' do
      let(:nums) { [5, 3, 7] }
      #    5
      #   / \
      #  3   7
    
      subject { tree.delete(7) }
      its(:max) { should == 5 }
      its(:height) { should == 1 }
      its(:left_height) { should == 1 }
      its(:right_height) { should == 0 }
      its(:balance_factor) { should == -1 }
    end
    
    context 'when removing single-child node' do
      let(:nums) { [5, 3, 7, 1, 9] }
      #      5
      #     / \
      #    3   7
      #   /     \
      #  1       9
      
      subject { tree.delete(1) }
      its(:min) { should == 3 }
      its(:height) { should == 2 }
      its(:left_height) { should == 1 }
      its(:right_height) { should == 2 }
      its(:balance_factor) { should == 1 }
    end
    
    context 'when removing two-child node' do
      let(:nums) { [5, 3, 7, 1, 9, 4] }
      #      5
      #     / \
      #    3   7
      #   / \   \
      #  1   4   9
      
      subject { tree.delete(5) }
      its(:val) { should == 4 }
      its(:height) { should == 2 }
      its(:left_height) { should == 2 }
      its(:right_height) { should == 2 }
      its(:balance_factor) { should == 0 }
    end
    
    context 'when removing a non-existant node' do
      let(:nums) { [5, 3, 7] }
      #    5
      #   / \
      #  3   7
    
      subject { tree.delete(100) }
      its(:height) { should == 1 }
      its(:left_height) { should == 1 }
      its(:right_height) { should == 1 }
      its(:balance_factor) { should == 0 }
    end
    
    context 'when removing the only node' do
      let(:nums) { [5] }
    
      subject { tree.delete(5) }
      it { should == nil }
    end
  end
  
end
