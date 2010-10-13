digits = 0..9
digits.first #=> 0
digits.first(3) #=> [0, 1, 2]
digits.drop(3) #=> [3, 4, 5, 6, 7, 8, 9]
digits.take(30)
#=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
digits.select{|e| e.even? and e.odd?}.first(2) #=> []
