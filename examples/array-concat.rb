parents = %w{Michael Susan}
grandparents = %w{Thomas Isobel}
$, = ?\ 
(parents + grandparents).join #=> "Michael Susan Thomas Isobel"
parents * ', '                #=> "Michael, Susan"
parents * 2
#=> ["Michael", "Susan", "Michael", "Susan"]
