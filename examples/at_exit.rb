at_exit { puts 1 }
puts 2
at_exit { puts 3 }
at_exit { puts 4 } if false
# Output:
# 2
# 3
# 1
