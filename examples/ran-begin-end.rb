Range.new(1.0, 3.0).begin #=> 1.0
(?a...?z).end #=> "z"
(:abc..:cba).first(10)
#=> [:abc, :abd, :abe, :abf, :abg, :abh, :abi, :abj, :abk, :abl]
(Rational(1,5)..1).first #=> (1/5)
