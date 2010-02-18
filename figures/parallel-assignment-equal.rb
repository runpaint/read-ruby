a, b, c = 1, 2, 3
a #=> 1
b #=> 2
c #=> 3

# Swap the values of two variables
a, b = b, a
a #=> 2
b #=> 1
# The following approach is wrong: 
# both variables end up with the same value!
a = b # Assign 1 to a
b = a # Assign 1 to b
