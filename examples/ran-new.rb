Range.new(0, 9).to_a
#=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
Range.new(0, 9, true).to_a
#=> [0, 1, 2, 3, 4, 5, 6, 7, 8]
Range.new(?a, ?z)
