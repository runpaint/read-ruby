if false    # This branch is not executed so the variable
  glark = 2 # is not assigned too, but is still initialized
end
defined? glark #=> 'local-variable'
glark #=> nil
