def ambig
  :uous
end
# In the absence of a local variable with the same name as a selector, the
# parentheses following the selector name are optional: there is no ambiguity. 
ambig #=> :uous
ambig() #=> :uous

# When such a variable is defined, the bare identifier refers to it; not the
# message. Parentheses are required to disambiguate.
ambig = :uity
ambig #=> :uity
ambig() #=> :uous
