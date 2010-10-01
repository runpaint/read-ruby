prime_fact = [[1, 1], [2, 1], [3, 1], [4, 2],
              [5, 1], [6, 2], [7, 1], [8, 3], [9, 2]]
prime_fact.transpose
#=> [[1, 2, 3, 4, 5, 6, 7, 8, 9], 
#    [1, 1, 1, 2, 1, 2, 1, 3, 2]]
prime_fact.transpose.transpose == prime_fact
#=> true
