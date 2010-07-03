"\xDB\x0FI@".unpack ?f      #=> [3.1415927410125732]
"\x18-DT\xFB!\t@".unpack ?d #=> [3.141592653589793]
sqrt = Math.sqrt 2         #=>  1.4142135623730951
[sqrt].pack(?f).unpack ?f  #=> [1.4142135381698608]
[sqrt].pack(?d).unpack ?d  #=> [1.4142135623730951]
