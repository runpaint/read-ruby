s = 'Aaa bbb cc dd e'
s.count('Aa-e')        #=> 11
s.count(?a, ?b)        #=> 0
s.count('a-d')         #=> 9
s.delete!('b-e', '^c') #=> "Aaa  cc  "
s.count('a-e', '^b')   #=> 4
s.count('A-Za-z ')     #=> 9
