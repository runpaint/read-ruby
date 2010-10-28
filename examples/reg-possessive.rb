 '123' =~ /^\d(2|4|6|8)?\d\d/                   #=> 0
'123' =~ /^\d(2|4|6|8)?+\d\d/                   #=> nil
'The "programmer" said...' =~ /"[[:graph:]]*"/  #=> 4
'The "programmer" said...' =~ /"[[:graph:]]*+"/ #=> nil
