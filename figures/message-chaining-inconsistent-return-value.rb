# String#strip! returns a String when it successfully strips surrounding
# whitespace from its receiver. This String is then used as the receiver for
# String#sub.
" All propositions are of equal value. ".strip!.sub(/\.$/,'!') 
#=> "All propositions are of equal value!"

# However, when String#strip! doesn’t find any surrounding whitespace it
# returns nil. nil does not respond to :sub, so the chain is broken.
"All propositions are of equal value.".strip!.sub(/\.$/,'!') 
#=> NoMethodError: undefined method `sub' for nil:NilClass
