[41.numerator, 41.denominator] #=> [41, 1]
r = Rational(136, 153)
[r.numerator, r.denominator]   #=> [8, 9]
f = r.to_f
[f.numerator, f.denominator]   #=> [2001599834386887, 2251799813685248]
r = f.rationalize
[r.numerator, r.denominator]   #=> [8, 9]
