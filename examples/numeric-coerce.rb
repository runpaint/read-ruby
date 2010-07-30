23.coerce 567 #=> [567, 23]
23.coerce 5.67 #=> [5.67, 23.0]
Math::PI.coerce Rational(1, 2) #=> [0.5, 3.141592653589793]
Complex(2).coerce Float::INFINITY #=> [(Infinity+0i), (2+0i)]
