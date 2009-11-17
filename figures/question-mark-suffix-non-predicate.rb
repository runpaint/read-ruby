3.5.infinite? #=> nil

3.5.fdiv(0.0) #=> Infinity
3.5.fdiv(0.0).infinite? #=> 1

-10.quo(0.0) #=> -Infinity
-10.quo(0.0).infinite? #=> -1
