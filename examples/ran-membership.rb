ages = 18..30
ages.include? 505 #=> false
ages.include? 25.0 #=> true
ages.include? 14 #=> false
(18...30).include? 30 #=> false
(Rational(1,10)..Rational(10, 1)).cover? 3 #=> true
(:above..:below).include? :angels #=> false
(:above..:below).cover? :angels #=> true
