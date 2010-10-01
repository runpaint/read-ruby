alpha = [*(?a..?z)]
(alpha.first..alpha.last).to_a[0] #=> "a"
alpha.last 3 #=> ["x", "y", "z"]
