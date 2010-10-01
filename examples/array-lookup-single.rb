colours = %w{red green blue}
"#{colours[0]}, #{colours.at(1)}, and #{colours.slice(-1)}"
#=> "red, green, and blue"
colours[4] #=> nil
colours.fetch(-5, 'white') #=> "white"
colours.fetch(4)
#=> index 4 outside of array bounds: -3...3 (IndexError)
