require "byebug"

# Write a method, least_common_multiple, that takes in two numbers and returns
# the smallest number that is a mutiple of both of the given numbers
def least_common_multiple(num_1, num_2)
  i = [num_1, num_2].min
  while i % num_1 != 0 || i % num_2 != 0
    i += 1
  end
  i
end


# Write a method, most_frequent_bigram, that takes in a string and returns the
# two adjacent letters that appear the most in the string.
def most_frequent_bigram(str)
  hash = Hash.new(0)

  i = 0
  while i < str.length - 2
    adj = str[i] + str[i+1]
    hash[adj] += 1
    i += 1
  end

  most = 0
  keys = []
  hash.each do |k, v|
    if v > most
      most = v
      keys << k 
    end
  end
  keys[-1]
end


class Hash
  # Write a method, Hash#inverse, that returns a new hash where the key-value
  # pairs are swapped
  def inverse
    hash = Hash.new()
    self.each do |k, v|
      hash[v] = k 
    end
    hash
  end
end


class Array
  # Write a method, Array#pair_sum_count, that takes in a target number returns
  # the number of pairs of elements that sum to the given target
  def pair_sum_count(num)
    pairs = []
    self.each_with_index do |n1, idx1|
      self.each_with_index do |n2, idx2|
        if idx2 > idx1
          pairs << [n1, n2] if n2 + n1 == num
        end
      end
    end
    pairs.length
  end


  # Write a method, Array#bubble_sort, that takes in an optional proc argument.
  # When given a proc, the method should sort the array according to the proc.
  # When no proc is given, the method should sort the array in increasing order.
  #
  # Sorting algorithms like bubble_sort commonly accept a block. That block
  # accepts two parameters, which represents the two elements in the array being
  # compared. If the block returns 1, it means that the second element passed to
  # the block should go before the first (i.e., switch the elements). If the
  # block returns -1, it means the first element passed to the block should go
  # before the second (i.e., do not switch them). If the block returns 0 it
  # implies that it does not matter which element goes first (i.e., do nothing).
  #
  # This should remind you of the spaceship operator! Convenient :)
  def bubble_sort(&prc)
    prc ||= Proc.new{|ele1, ele2| ele1 <=> ele2}

    unsorted = true
    while unsorted
      unsorted = false
      i = 0
      while i < self.length - 1
        if prc.call(self[i], self[i+1]) == 1 
          unsorted = true
          self[i], self[i+1] = self[i+1], self[i]
        end
        i+=1
      end
    end
    self
  end
end