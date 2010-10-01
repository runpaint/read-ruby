words = %w{zero one two three four five}
words.sort!
#=> ["five", "four", "one", "three", "two", "zero"]
words.reverse
#=> ["zero", "two", "three", "one", "four", "five"]
words.shuffle
#=> ["two", "three", "five", "one", "four", "zero"]
