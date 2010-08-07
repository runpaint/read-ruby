name = :size
"wool".name
#=> NoMethodError: undefined method `name' for "wool":String
"wool".send(name) #=> 4
33.send(:/, 3)    #=> 11

