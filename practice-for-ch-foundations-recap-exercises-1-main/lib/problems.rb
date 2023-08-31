require "byebug"

# Write a method, all_vowel_pairs, that takes in an array of words and returns
# all pairs of words that contain every vowel. Vowels are the letters a, e, i,
# o, u. A pair should have its two words in the same order as the original
# array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"]) # => ["action europe", "tear impromptu"]
def all_vowel_pairs(words)
  pairs = []
  vowels = ["a", "e", "i", "o", "u"]
  words.each_with_index do |word1, idx1|
    words.each_with_index do |word2, idx2|
      if all_vowels?(word1+word2) && idx2 > idx1
        pairs << word1 + " " + word2
      end
    end
  end
  pairs
end


def all_vowels?(word)
  vowels = ["a", "e", "i", "o", "u"]
  vowels.all? {|vowel| word.include?(vowel) }
end


# Write a method, composite?, that takes in a number and returns a boolean
# indicating if the number has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true composite?(13)    # => false
def composite?(num)
  if num == 0 || num == 1
    return false
  end
  (2...num).each do |n|
    return true if num % n == 0
  end
  false
end


# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the order of their appearance in the
# original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]
def find_bigrams(str, bigrams)
  selected = bigrams.select {|bigram| str.include?(bigram)}
end


# Write a method, Hash#my_select, that takes in an optional proc argument
# The method should return a new hash containing the key-value pairs that return
# true when passed into the proc.
# If no proc is given, then return a new hash containing the pairs where the key
# is equal to the value.
#
# Examples:
#
# hash_1 = {x: 7, y: 1, z: 8}
# hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
#
# hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
# hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
# hash_2.my_select                            # => {4=>4}
class Hash
  def my_select(&prc)
    prc ||= Proc.new {|k, v| k == v}
    new_hash = self.select(&prc)
    new_hash.to_h
  end
end


# Write a method, String#substrings, that takes in a optional length argument
# The method should return an array of the substrings that have the given length.
# If no length is given, return all substrings.
#
# Examples:
#
# "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
# "cats".substrings(2)  # => ["ca", "at", "ts"]
class String
  def substrings(length = nil)
    substring = []
    lengths = length || false
    self.split("").each_with_index do |sub1, idx1|
      substring << sub1
      self.split("").each_with_index do |sub2, idx2|
        if idx2 > idx1
          substring << self[idx1..idx2]
        end
      end
    end

    if length
      p length
      return substring.select {|ele| ele.length = length}
    else
      return substring
    end
  end
end


# Write a method, String#caesar_cipher, that takes in an a number.
# The method should return a new string where each char of the original string
# is shifted the given number of times in the alphabet.
#
# Examples:
#
# "apple".caesar_cipher(1)    #=> "bqqmf"
# "bootcamp".caesar_cipher(2) #=> "dqqvecor"
# "zebra".caesar_cipher(4)    #=> "difve"
class String
  def caesar_cipher(num)
    translated = self.split("").map {|char| translate_letter(char, num)}
    translated.join("")
  end

  def translate_letter(char, num)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    index = alphabet.index(char) + num
    if index > 25
      index = index % 26 
      return alphabet[index]
    else
      return alphabet[index]
    end
  end
end