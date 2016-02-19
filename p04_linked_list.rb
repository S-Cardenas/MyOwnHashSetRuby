class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList

  include Enumerable

  def render
    node = @head
    puts node
    return nil if node.nil?
    until node.next.nil?
      node = node.next
      puts node
    end
  end


  def initialize
    @head = nil
    @tail = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    return false if @head == nil
    true
  end

  def get(key)
    node = @head
    until node.key == key
      return nil if node.next.nil?
      node = node.next
    end
    node.val
  end

  def include?(key)
    node = @head
    until node.key == key
      return false if node.next.nil?
      node = node.next
    end
    true
  end

  def insert(key, val)
    if @head.nil?
      insert_head(key,val)
    else
      parent = @head
      while parent.next
        parent = parent.next
      end
      @tail = Link.new(key, val)

      parent.next = @tail
      parent.next.prev = parent
    end
  end

  def insert_head(key, val)
    @head = Link.new(key, val)
    @head.prev = nil
  end

  def remove(key)
    return nil unless include?(key)
    if @head.key == key
      remove_head
    else
      node = @head
      until node.key == key
        node = node.next
      end
      node.prev.next = node.next
      node.next.prev = node.prev unless @tail == node
    end
  end

  def remove_head
    @head = @head.next
    @head.prev = nil
  end

  def set_value(key, val)
    node = @head
    vode.val = val if node.key == key
    until node.next.nil?
      node = node.next
      vode.val = val if node.key == key
    end
    nil
  end

  def each(&proc)
    node = @head
    proc.call(node.val)
    until node.next.nil?
      node = node.next
      proc.call(node.val)
    end
    nil
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
