puts 1
BEGIN { puts 2 } if false
puts 3
# Output:
# 2
# 1
# 3
