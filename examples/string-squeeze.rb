s = 'Aaa bbb cc dd e'
s.squeeze              #=> "Aa b c d e"
s.squeeze(?a, ?b)      #=> "Aaa bbb cc dd e"
s.squeeze('a-d')       #=> "Aa b c d e"
s.squeeze('a-e', '^b') #=> "Aa bbb c d e"
