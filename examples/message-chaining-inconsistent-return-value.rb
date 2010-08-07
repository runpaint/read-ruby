" All propositions are of equal value. ".strip!.sub(/\.$/,'!') 
#=> "All propositions are of equal value!"
"All propositions are of equal value.".strip!.sub(/\.$/,'!') 
#=> NoMethodError: undefined method `sub' for nil:NilClass
