def scope
  variable = 1 # Initialize local variable
  3.times do
    variable += 1 # Increment the same variable 
  end
  variable
end
scope #=> 4
# After the block the variable is no longer defined
defined? variable #=> nil
