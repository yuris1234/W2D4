require "byebug"

def no_dupes?(arr)
    hash = Hash.new(0)
    arr.each {|ele| hash[ele] += 1}
    repeat = []
    hash.each do |k, v|
        repeat << k if v == 1
    end
    repeat
end

# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    i = 0
    while i < arr.length - 1
        return false if arr[i] == arr[i+1]
        i+=1
    end
    true
end

# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                              # => true

def char_indices(str)
    hash = Hash.new() {|h, k| h[k] = Array.new()}
    str.each_char.with_index do |char, idx|
        hash[char] << idx
    end
    hash
end

# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    streak = 1
    longest_streak = 0
    consecutive = ""
    i = 0
    while i < str.length
        if str[i] == str[i+1]
            streak += 1
        else
            if streak >= longest_streak
                longest_streak = streak
                consecutive = str[i] * streak
            end
            streak = 1
        end
        i += 1
    end

    if str.length == 1 
        return str[0]
    elsif str.length == 0
        return ""
    end

    consecutive

end

# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'

def bi_prime?(num)
    (2...num).each do |n1|
        (2...num).each do |n2|
            if is_prime?(n1) && is_prime?(n2) && n1 * n2 == num
                return true
            end
        end
    end
    false

end

def is_prime?(num)
    (2...num).each do |n|
        if num % n == 0
            return false
        end
    end
    true
end

# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false

def vigenere_cipher(word, keys)
    translated = []
    word.each_char do |char|
        translated << translate(char, keys[0])
        keys = keys.rotate
    end
    translated.join("")

end

def translate(word, key)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    idx = alphabet.index(word) + key
    if idx > 25
        idx = idx % 26 
    end
    alphabet[idx]
end

# Examples
# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
    vowels = str.split("").select {|char| "aeiou".include?(char)}
    vowels = vowels.rotate(-1)
    arr = str.split("").map do |char|
        if "aeiou".include?(char)
            char = vowels[0]
            vowels = vowels.rotate(1)
            char
        else
            char
        end
    end
    arr.join("")
end

# Examples
# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"

class String
    def select(&prc)
        if prc == nil
            return ""
        end
        str = ""
        self.each_char do |char|
            str += char if prc.call(char) == true
        end
        str
    end

# # Examples
# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""

    def map!(&prc)
        self.each_char.with_index do |char, idx|
            p char
            p idx
            self[idx] = prc.call(char, *idx)
        end
    end
end

# word_1 = "Lovelace"
# word_1.map! do |ch| 
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"

def multiply(a, b)
    #base case
    if b == 1
        return a.abs
    elsif b == 0
        return 0
    end

    if [a, b].one? {|ele| ele < 0}
        return 0 - (a.abs + multiply(a.abs, b.abs - 1)) 
    else
        return a.abs + multiply(a.abs, b.abs - 1)
    end
end

# Examples
# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18

def lucas_sequence(length)
    if length == 0
        return []
    elsif length == 1
        return [1]
    elsif length == 2
        return [2, 1]
    end
    arr = lucas_sequence(length - 1)
    arr << arr[-1] + arr[-2]
    arr

end

# p lucas_sequence(0)   # => []
# p lucas_sequence(1)   # => [2]    
# p lucas_sequence(2)   # => [2, 1]
# p lucas_sequence(3)   # => [2, 1, 3]
# p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
# p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]

def prime_factorization(num)
    (2...num).each do |n|
        if num % n == 0
            other_fact = num / n
            prime_factorization(n)
            prime_factorization(other_fact) 
            return prime_factorization(n).concat(prime_factorization(other_fact))
        end
    end

    return [num]
end

# Examples

# p prime_factorization(8)
# p prime_factorization(12)     # => [2, 2, 3]
# p prime_factorization(24)     # => [2, 2, 2, 3]
# p prime_factorization(25)     # => [5, 5]
# p prime_factorization(60)     # => [2, 2, 3, 5]
# p prime_factorization(7)      # => [7]
# p prime_factorization(11)     # => [11]
# p prime_factorization(2017)   # => [2017]