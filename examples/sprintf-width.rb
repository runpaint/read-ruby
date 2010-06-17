digits = [*(1..9)]
'%1s' % digits.join
#=> "123456789"
'%20s = %#x' % [digits.join, digits.reduce(:+)]
#=> "           123456789 = 0x2d"
'>%0-20X<' % [*digits.join.bytes].join
#=> ">6DEC6BD4A460909     <"
