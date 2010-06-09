puts "STDOUT" # Written to STDOUT
$stdout = STDERR
puts "STDERR" # Written to STDERR
$stdout = STDOUT
puts "STDOUT" # Written to STDOUT

# From the command-line:
# $ ruby stdout-redirection.rb 
# STDOUT
# STDERR
# STDOUT
# $ ruby stdout-redirection.rb 2>/dev/null
# STDOUT
# STDOUT
