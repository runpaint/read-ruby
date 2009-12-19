# Create a closure referencing an undefined _array_ variable 
size = ->{ array.size }
# Define an _array_ variable in the same scope 
array = [1,2,3]
# A NameError is raised because _array_ was not 
# defined in the closure’s binding
size.call #=> NameError: undefined local variable or method `array' for main:Object
