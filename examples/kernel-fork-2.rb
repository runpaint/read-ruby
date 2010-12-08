print "\nIn #{(pid = fork) ? "parent (#{pid})" : "child (#{Process.pid})"}: "
2.times{|i| print "#{i} "}
# Prints:
#
# In parent (24225): 0 1 
# In child (24225): 0 1
