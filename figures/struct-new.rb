Element = Struct.new(:name, :symbol, :atomic_number, :mass)
as = Element.new(:Arsenic, :As, 33, 74.92)
as.mass #=> 74.92
