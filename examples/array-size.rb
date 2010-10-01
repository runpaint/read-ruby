ascii = (0..127).map(&:chr)
ascii.size         #=> 128
ascii *= 2
ascii.size         #=> 256
ascii.clear.empty? #=> true
