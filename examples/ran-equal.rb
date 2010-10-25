(5..6) == (5..6) #=> true
(:an..:other) == (:an...:other) #=> false
(-Float::INFINITY..Float::INFINITY).eql?(Range.new(0, Float::INFINITY)) #=> false
