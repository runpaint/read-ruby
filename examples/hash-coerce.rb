{}.to_hash #=> {}
Hash[*(1..6)] #=> {1=>2, 3=>4, 5=>6}
{a: :value, b: [:key]}.to_a #=> [[:a, :value], [:b, [:key]]]
Hash.try_convert(try: :again) #=> {:try=>:again}
Hash.try_convert([:element]) #=> nil
h = { Object.new => Rational(2, 3) }
h[:h] = h
h.to_s #=> "{#<Object:0x00000001388e38>=>(2/3), :h=>{...}}"
