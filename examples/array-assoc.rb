one = [[Rational(2, 3), Rational(1, 3)],
       [Rational(3, 5), Rational(2, 5)],
       [Rational(4, 7), Rational(3, 7)]]
one.assoc Rational(3, 5)  #=> [(3/5), (2/5)]
one.rassoc Rational(2, 7) #=> [(4/7), (3/7)]
one.assoc 1               #=> nil
