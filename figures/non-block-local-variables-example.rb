v = :out
1.times do 
  v, w = :in, :in 
  p [v, w]
end #=> [:in, :in]
v #=> :in
w #=> NameError
