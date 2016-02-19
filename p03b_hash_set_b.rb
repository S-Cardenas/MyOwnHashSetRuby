class MyHashMap
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new { Array.new } }
    @count = 0
  end

  def insert(key, value)
    self[key.hash % num_buckets] << [key, value]
    @count += 1
    resize! if @count > num_buckets
  end

  def include?(key)
    self[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    @store[key.hash % num_buckets].each_with_index do |subarray, idx|
      if subarray.first == key
        @count -= 1
        @store[key.hash % num_buckets].delete_at(idx)
      end
    end
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    keys = @store.flatten(1)
    new_store = Array.new(@store.length * 2) { Array.new }
    @store = new_store
    @count = 0
    keys.each { |key| self.insert(key.first, key.drop(1)) }
  end
end
