3 == 3.0                          #=> true
a, b = 3.coerce(3.0)              #=> [3.0, 3.0]
a.eql? b                          #=> true

Rational(2, 3) == 2.3             #=> false
a, b = Rational(2, 3).coerce(2.3) #=> [2.3, 0.6666666666666666]
a.eql? b                          #=> false
