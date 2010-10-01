a = 'James Joyce'.chars.map(&:upcase!)
#=> [nil, "A", "M", "E", "S", nil, nil, "O", "Y", "C", "E"]
a.compact!
#=> ["A", "M", "E", "S", "O", "Y", "C", "E"]
a.uniq 
#=> ["A", "M", "E", "S", "O", "Y", "C"]
a.compact!
#=> nil
