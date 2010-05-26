# `a` and `b` are normal parameters; `c` and `d` are block-local        
Proc.new { |a, b=3.14;c, d| }
->(a, b=3.14;c, d){ }
