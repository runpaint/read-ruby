enu = [1, 1, 3, 5, 5, 5, 5, 6, 8, 10, 12, -12, 1, 2]
enu.count #=> 14
enu.count(1.0) #=> 3
enu.count(7) #=> 0 
enu.count{|n| n.odd? and n > 0} #=> 8
enu.clear.count #=> 0
[%w{a b}, %w{c d}].count([?a, ?b]) #=> 1
