s = 'next'
s.succ! #=> 'nexu'
[*s.upto('neya')]
#=> ["nexu", "nexv", "nexw", "nexx", "nexy", "nexz", "neya"]
?(.upto(11.to_s).to_a
#=> ["(", ")", "*", "+", ",", "-", ".", "/", "0", "1", "2", 
#    "3", "4", "5", "6", "7", "8", "9", "10", "11"]
