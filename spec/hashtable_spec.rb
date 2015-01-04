$:<< File.dirname(__FILE__) << "#{File.dirname(__FILE__)}/.."
require 'hashtable'
require 'rspec'

describe Hashtable do

  let(:h) { described_class.new }
  let(:k1) { 'KEY1' }
  let(:k2) { 'KEY2' }
  let(:v1) { 'VAL1' }
  let(:v2) { 'VAL2' }
  
  
  it 'returns nil when a key is not present' do
    h.get(k1).should == nil
  end
  
  it 'stores a value at a key' do
    h.set(k1, v1)
    h.get(k1).should == v1
  end
  
  it 'stores multiple values at unique keys' do
    h.set(k1, v1)
    h.set(k2, v2)
    h.get(k1).should == v1
    h.get(k2).should == v2
  end
  
  it 'overwrites a value at an already-present key' do
    h.set(k1, v1)
    h.set(k1, v2)
    h.get(k1).should == v2
  end
  
  it 'properly removes a present key' do
    h.set(k1, v1)
    h.remove(k1)
    h.get(k1).should == nil
  end
  
  it 'does not choke when removing a non-present key' do
    h.remove(k1)
  end

end
