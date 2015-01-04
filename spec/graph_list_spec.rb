$:<< File.dirname(__FILE__) << "#{File.dirname(__FILE__)}/.."
require 'graph_list'
require 'rspec'

describe GraphList do
  
  let(:graph) {
    g = described_class.new(directed)
    data.keys.each{|v| g.add_node(v) }
    data.each do |v1, v2s|
      v2s.each{|v2| g.add_edge(v1, v2) }
    end
    g
  }
  
  context 'using example data' do
    let(:data) { {
      a: [:b, :c, :d],
      b: [:e],
      c: [:e, :f],
      d: [:f],
      e: [:g],
      f: [],
      g: []
    } }
    #     a       (all directed edges point downwards)
    #   / | \ 
    #  b  c  d
    #  \ / \ /
    #   e   |
    #   |   |
    #   g   f
    
    context 'in a directed graph' do
      let(:directed) { true }
      
      describe '#successors' do
        { a: [:b, :c, :d],
          b: [:e],
          c: [:e, :f],
          d: [:f],
          e: [:g],
          f: [],
          g: []
        }.each do |start, successors|
          it "yields the correct list for #{start}" do
            expect(graph.successors(start)).to eq(successors)
          end
        end
      end
  
      describe '#breadth_first' do
        { a: [:a, :b, :c, :d, :e, :f, :g],
          b: [:b, :e, :g],
          c: [:c, :e, :f, :g],
          d: [:d, :f],
          e: [:e, :g],
          f: [:f],
          g: [:g]
        }.each do |start, traversal|
          it "yields the correct traversal starting from #{start}" do
            expect(graph.breadth_first(start)).to eq(traversal)
          end
        end      
      end
      
      describe '#depth_first' do
        # NOTE depth_first uses a stack (instead of queue, like breadth_first),
        #  so we go from right to left on the diagram (instead of left to right)
        { a: [:a, :d, :f, :c, :e, :g, :b],
          b: [:b, :e, :g],
          c: [:c, :f, :e, :g],
          d: [:d, :f],
          e: [:e, :g],
          f: [:f],
          g: [:g]
        }.each do |start, traversal|
          it "yields the correct traversal starting from #{start}" do
            expect(graph.depth_first(start)).to eq(traversal)
          end
        end
      end
      
    end
    
    context 'in an undirected graph' do
      let(:directed) { false }

      describe '#successors' do
        { a: [:b, :c, :d],
          b: [:a, :e],
          c: [:a, :e, :f],
          d: [:a, :f],
          e: [:b, :c, :g],
          f: [:c, :d],
          g: [:e]
        }.each do |start, successors|
          it "yields the correct list for #{start}" do
            expect(graph.successors(start)).to eq(successors)
          end
        end
      end
      
      describe '#breadth_first' do
        { a: [:a, :b, :c, :d, :e, :f, :g],
          b: [:b, :a, :e, :c, :d, :g, :f],
          c: [:c, :a, :e, :f, :b, :d, :g],
          d: [:d, :a, :f, :b, :c, :e, :g],
          e: [:e, :b, :c, :g, :a, :f, :d],
          f: [:f, :c, :d, :a, :e, :b, :g],
          g: [:g, :e, :b, :c, :a, :f, :d]
        }.each do |start, traversal|
          it "yields the correct traversal starting from #{start}" do
            expect(graph.breadth_first(start)).to eq(traversal)
          end
        end      
      end
      
      describe '#depth_first' do
        # NOTE depth_first uses a stack (instead of queue, like breadth_first),
        #  so we go from right to left on the diagram (instead of left to right)
        { a: [:a, :d, :f, :c, :e, :g, :b],
          b: [:b, :e, :g, :c, :f, :d, :a],
          c: [:c, :f, :d, :a, :b, :e, :g],
          d: [:d, :f, :c, :e, :g, :b, :a],
          e: [:e, :g, :c, :f, :d, :a, :b],
          f: [:f, :d, :a, :c, :e, :g, :b],
          g: [:g, :e, :c, :f, :d, :a, :b]
        }.each do |start, traversal|
          it "yields the correct traversal starting from #{start}" do
            expect(graph.depth_first(start)).to eq(traversal)
          end
        end
      end
      
    end
    
  end
  
  
  context 'using example data (small set)' do
    let(:data) { {
      a: [:b, :c],
      b: [:d],
      c: [:d],
      d: []
    } }
    #   a      (all directed edges point downwards)
    #  / \
    # b   c
    #  \ /
    #   d
    
    data_keys = [:a, :b, :c, :d] # hack b/c `data` isn't in scope
  
    [true, false].each do |directed| # ugly way to macro this out...
    
      context (directed ? 'in a directed graph' : 'in an undirected graph') do
        let(:directed) { directed }
        
        data_keys.each do |v1| # more ugly macroing...
        
          describe "#delete_node(#{v1})" do 
            before(:each) { graph.delete_node(v1) }
            
            it "disconnects #{v1} from the graph" do
              graph.successors(v1) == nil
            end
            
            it "removes #{v1} from any succesor lists" do
              (data_keys - [v1]).each do |v2|
                expect(graph.successors(v2)).not_to include(v1)
              end
            end
          end
          
          (data_keys - [v1]).each do |v2| # more ugly macroing... (this gives me an idea for a DSL)
          
            describe "#delete_edge(#{v1}, #{v2})" do
              before(:each) { graph.delete_edge(v1, v2) }
            
              it "removes #{v2} from #{v1}'s successors" do
                expect(graph.successors(v1)).not_to include(v2)
              end
              
              unless directed
                it "removes #{v1} from #{v2}'s successors" do
                  expect(graph.successors(v2)).not_to include(v1)
                end
              end
            end
            
          end
          
        end

      end
      
    end
    
  end
  
end
