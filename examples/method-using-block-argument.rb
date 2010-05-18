def m(&block)
  puts "This block returns: #{block.call}" if block_given?
end
m { 1 + 2 } #=> This block returns: 3
m #=> nil
