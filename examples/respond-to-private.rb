'uninitialized'.private_methods.include? :initialize #=> true
'uninitialized'.respond_to? :initialize #=> false
'uninitialized'.respond_to? :initialize, true #=> true
