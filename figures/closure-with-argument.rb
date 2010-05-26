array=[*('a'..'c')] #=> ["a", "b", "c"]
element =->(i){ print "#{i}=#{array[i]} " }
# For each element of _array_, call the _element_ 
# closure with the index as an argument
array.each_index {|i| element[i] } #=> 0=a 1=b 2=c
