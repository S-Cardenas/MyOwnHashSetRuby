require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap

  attr_reader :count

  def render
    @store.each_with_index do |list, idx|
      print "#{idx}=>\n"
      if list.is_a?(LinkedList)
        list.render
      else
        print "empty"
      end
    end
  end

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def insert(key, value)
    @store[key.hash % num_buckets].insert(key, value)
    # self[key.hash % num_buckets] << [key, value]
    @count += 1
    resize! if @count > num_buckets
  end

  def include?(key)
    self[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    linkedlist = @store[key.hash % num_buckets]
    linkedlist.insert(key, val)
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def remove(key)
    @store[key.hash % num_buckets].each do |link|
      if link.key == key
        @count -= 1
        @store[key.hash % num_buckets].remove(key)
      end
    end
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private


  def num_buckets
    @store.length
  end

  def [](num)
    @store[num % num_buckets]
  end

  def resize!
    keys = @store.flatten(1)
    new_store = Array.new(@store.length * 2) { LinkedList.new }
    @store = new_store
    @count = 0
    keys.each { |key| self.insert(key.first, key.drop(1)) }
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end



end

hash = HashMap.new
hash.set(:first, 1)
hash.set(:second, 2)
hash.set(:third, 3)
hash.insert(:four, 4)
hash.insert('something', [1,2,3,3,4,5,6,7])
hash.insert([1,2,3], 'something else')
hash.render
