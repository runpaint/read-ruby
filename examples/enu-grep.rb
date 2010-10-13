Enumerable.instance_methods.grep(/while/)
#=> [:take_while, :drop_while]
(1..100).grep(5..7)
#=> [5, 6, 7]
(1..1000).grep(->(e){ e.to_s(2) =~ /^110+11$/})
#=> [27, 51, 99, 195, 387, 771]
