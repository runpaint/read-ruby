puts "Parent: #{Process.ppid} -> #{Process.pid}"
fork do
  puts "Child: #{Process.ppid} -> #{Process.pid}"
end

# Prints:  
# Parent: 6653 -> 16743
# Child: 16743 -> 16745
