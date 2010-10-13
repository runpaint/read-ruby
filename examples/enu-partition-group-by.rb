square, nonsquare = (1..25).partition{|n| Math.sqrt(n) == Math.sqrt(n).to_i}
#=> [[1, 4, 9, 16, 25], 
#=>  [2, 3, 5, 6, 7, 8, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 21, 22, 23, 24]]
(1..10).group_by{|n| 10.lcm n}
#=> {10=>[1, 2, 5, 10], 30=>[3, 6], 20=>[4], 70=>[7], 40=>[8], 90=>[9]}
String.instance_methods.group_by{|m| String.instance_method(m).arity}.map{|a,m| [a, m.size]}
#=> [[1, 42], [0, 71], [-1, 47], [2, 9]]
