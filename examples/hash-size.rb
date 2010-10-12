h = {}
h.size   #=> 0
h.empty? #=> true
h[3] = 4
h[4] = 5
h[5] = nil
h.size   #=> 3
h.empty? #=> false
