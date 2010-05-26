module Math
  PLASTIC = cbrt(0.5 + Rational(1, 6) * sqrt(Rational(23, 3))) + 
            cbrt(0.5 - Rational(1, 6) * sqrt(Rational(23, 3)))
end
Math::PLASTIC #=> 1.3247179572447458
