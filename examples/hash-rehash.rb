coords = {[0,0] => :origin}
treasure = [32,19]
coords[treasure] = :gold
treasure[-1] += 1
coords #=> {[0, 0]=>:origin, [32, 20]=>:gold}
coords[treasure] #=> nil
coords.rehash
coords[treasure] #=> :gold
