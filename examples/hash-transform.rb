demonyms = {Barbados: :Bajan, Spain: :Spaniard, Ireland: :Irish, 
            Australia: [:Australian, :Aussie], Peru: :Peruvian}
demonyms.flatten
#=> [:Barbados, :Bajan, :Spain, :Spaniard, :Ireland, :Irish, 
#=>  :Australia, [:Australian, :Aussie], :Peru, :Peruvian]
demonyms.flatten 2
#=> [:Barbados, :Bajan, :Spain, :Spaniard, :Ireland, :Irish, 
#=>  :Australia, :Australian, :Aussie, :Peru, :Peruvian]
demonyms.invert
#=> {:Bajan=>:Barbados, :Spaniard=>:Spain, :Irish=>:Ireland, 
#=>  [:Australian, :Aussie]=>:Australia, :Peruvian=>:Peru}
