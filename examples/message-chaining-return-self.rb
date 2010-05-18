# String#strip always returns a String, allowing it to be chained
" All propositions are of equal value. ".strip.sub(/\.$/,'!') 
#=> "All propositions are of equal value!"

"All propositions are of equal value.".strip.sub(/\.$/,'!') 
#=> "All propositions are of equal value!"
