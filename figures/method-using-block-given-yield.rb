def m
  puts "This block returns: #{yield}" if block_given?
end
m { 1 + 2 } #=> This block returns: 3
m #=> nil
