(10..15).to_a
#=> [10, 11, 12, 13, 14, 15]
{first: 1, second: 2, third: 3}.to_a
#=> [[:first, 1], [:second, 2], [:third, 3]]
[[:glark], 1..2, {}, :sym, ?c].select{|e| e.respond_to? :to_ary}
#=> [[:glark]]
Array(Complex(2, 3))
#=> [(2+3i)]
Array(key: :value)
#=> [[:key, :value]]
Array([Math::PI, Math::E])
#=> [3.141592653589793, 2.718281828459045]
