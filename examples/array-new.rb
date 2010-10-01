Array.new #=> []
Array.new 3 #=> [nil, nil, nil]
Array.new 5, :default
#=> [:default, :default, :default, :default, :default]
Array.new [42] #=> [42]
Array.new(10){|i| i**i}
#=> [1, 1, 4, 27, 256, 3125, 46656, 
#    823543, 16777216, 387420489]
