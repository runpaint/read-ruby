def m
  puts "Thanks" if block_given?
end
m { 1 + 2 } #=> "Thanks"
m #=> nil
