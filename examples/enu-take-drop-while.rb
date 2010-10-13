digits = 1..9
require 'prime'
square_free = ->(n){ n.prime_division.all?{|a,b| b == 1} }
digits.take_while(&square_free) #=> [1, 2, 3]
digits.drop_while(&square_free) #=> [4, 5, 6, 7, 8, 9]
