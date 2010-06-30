str = 'Out of memory'
str.split #=> ["Out", "of", "memory"]
str.split('o') #=> ["Out ", "f mem", "ry"]
str.split(/o\s?/i) #=> ["", "ut ", "f mem", "ry"]
str.partition('o') #=> ["Out ", "o", "f memory"]
str.rpartition('o') #=> ["Out of mem", "o", "ry"]
