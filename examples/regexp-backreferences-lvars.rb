phrase = 'Aut disce aut discede'
/(?<either>\w+) (?<learn>\w+) (?<_or>\k<either>) (?<leave>\w+)/i =~ phrase
[either, learn, _or, leave] #=> ["Aut", "disce", "aut", "discede"]
/\A(ab|ex) (?<one>uno) (?<learn>#{learn})/ =~ 'Ex uno disce omnes' #=> nil
learn #=> "disce"
defined?(one) #=> nil
'Aut...' =~ /Aut(?<ellipsis>\.{3})/ #=> 0
defined?(ellipsis) #=> nil
