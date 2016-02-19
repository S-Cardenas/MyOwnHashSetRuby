class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = ""
    self.each_with_index do |el, idx|
      result += el.hash.abs.to_s
      result += idx.to_s
    end
    result = result.to_i % 1_800_000_000_000_000
    result = result.to_s
    while result.to_s.length < 16
      result += "0"
    end
    result.to_i
  end
end

class String
  def hash
    result = ''
    self.chars.each_with_index do |char, idx|
      result += char.ord.to_s + idx.to_s
    end
    result = result.to_i % 1_800_000_000_000_000
    result = result.to_s
    while result.to_s.length < 16
      result += "0"
    end
    result.to_i
  end
end

class Hash
  def hash
    result = []
    self.each do |key, value|
      result << (key.hash.to_s + value.hash.to_s).to_i
    end
    result = result.inject(0) { |sum, x| sum + x }
    result = result % 1_800_000_000_000_000
    result = result.to_s
    while result.to_s.length < 16
      result += "0"
    end
    result.to_i
  end
end
