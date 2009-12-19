variable = :first
# Use a lambda literal to create a closure 
# whose function is the block and environment 
# includes  _variable_. Assign the closure 
# to a variable.
closure = ->{ "variable = #{variable}" }
# Invoke the closure, using the value 
# of _variable_ from its environment
closure.call #=> "variable = first"
# Assign a different value to a variable 
# in the closure’s environment
variable = :second
# Re-invoke the closure in the context 
# of its current environment, where the 
# value of _variable_ is :second  
closure.call #=> "variable = second"
