# Extract sequences of consecutive digits
'one: 1, ten: 10, one-hundred: 100'.scan(/\d+/)
#=> ["1", "10", "100"]

# Separate a String into substrings separated by ', '
'Asia, Africa, North America, South America, Antarctica, Europe, Australia'.
  split(/, /)
#=> ["Asia", "Africa", "North America", "South America", 
#    "Antarctica", "Europe", "Australia"]
