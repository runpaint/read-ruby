v = :out
1.times do |;v,w| # Define `v` and `w` block-local
  v, w = :in, :in 
  p [v, w]
end #=> [:in, :in]
# `v` preserves its value from before the block
v #=> :out
# `w` wasn’t defined outside the block, so it still isn’t 
w #=> NameError: undefined local variable or method `w' for main:Object
