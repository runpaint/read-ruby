VOWELS = %w{a e i o u}
['d', 'e'].each do |letter|
  puts "#{letter} is a %s" % (VOWELS.include?(letter) ? "vowel" : "consonant")
end
#=> "d is a consonant"
#=> "e is a vowel"
