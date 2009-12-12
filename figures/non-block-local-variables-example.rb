v = :out
1.times do 
  v, w = :in, :in 
  p [v, w]
end #=> [:in, :in]
# `v` *doesn’t* preserve its value from before the block
v #=> :in
# `w` wasn’t defined outside the block, so it still isn’t 
w #=> NameError: undefined local variable or method `w' for main:Object
