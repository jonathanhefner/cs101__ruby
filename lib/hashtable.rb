class Hashtable

  class KeyVal < Struct.new(:key, :val); end

  def initialize(bucket_count = 16)
    @bucket_count = bucket_count
    @buckets = bucket_count.times.inject([]){|bs, i| bs << [] }
  end

  def set(key, val)
    bucket = @buckets[key.hash % @bucket_count]
    kv = bucket.find{|e| e.key == key }
    if kv
      kv.val = val
    else
      bucket << KeyVal.new(key, val)
    end  
  end
  
  def get(key)
    bucket = @buckets[key.hash % @bucket_count]
    kv = bucket.find{|e| e.key == key }
    kv && kv.val  
  end
  
  def remove(key)
    bucket = @buckets[key.hash % @bucket_count]
    i = bucket.index{|e| e.key == key }
    bucket.delete_at(i) if i
  end
  
end
