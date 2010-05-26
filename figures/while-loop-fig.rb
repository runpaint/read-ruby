def farey(n)
  a, b, c, d = 0, 1,  1, n
  while c < n
    k = (n + b)/d
    a, b, c, d = c, d, k*c - a, k*d - b
    (sequence ||= []) << Rational(a, b)
  end
  sequence.unshift Rational(0, 1)
end
farey(4) #=> [(0/1), (1/4), (1/3), (1/2), (2/3), (3/4), (1/1)]
