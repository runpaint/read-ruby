raise TypeError
#=> #<TypeError: TypeError>

raise "Quantum entanglement failed"
#=> <RuntimeError: Quantum entanglement failed>

obj = Object.new
def obj.exception
  NameError.new("We're supposed to be anonymous!")
end
raise obj
#=> #<NameError: We're supposed to be anonymous!>
