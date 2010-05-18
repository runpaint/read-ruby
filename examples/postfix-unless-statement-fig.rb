def palindrome?(string)
  raise ArgumentError unless string = String.try_convert(string)
  string = string.scan(/\w/).join.downcase
  string == string.reverse
end

palindrome?("Go hang a salami I'm a lasagna hog.") #=> true
palindrome?("Level, madam, level!") #=> true
palindrome?("canon a 2 cancrizans") #=> false
palindrome?(['mad']) #=> ArgumentError
