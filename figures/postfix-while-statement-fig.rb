# (n.to_s(2).count('1') works just as well, of course)
def bits_set(n)
  bits_set = 0
  n &= n - 1 while n > 0 && bits_set += 1
  bits_set
end
[33, 736, 128].map{|n| bits_set(n)} #=> [2, 4, 1]
