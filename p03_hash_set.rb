require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    self[key.hash % num_buckets] << key
    @count += 1
    resize! if @count > num_buckets
  end

  def include?(key)
    self[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    @count -= 1 if self[key.hash % num_buckets].include?(key)
    self[key.hash % num_buckets].delete(key)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    values = @store.flatten
    new_store = Array.new(@store.length * 2) { Array.new }
    @store = new_store
    @count = 0
    values.each { |key| self.insert(key) }
  end
end
