prng = Random.new 0xDEAF
prng.rand                #=> 0.9812733995904889
prng.rand 30             #=> 1
prng.rand Math::PI       #=> 0.21283178272607403
prng.rand(2**10..2**100) #=> 1018356302920191178791579529869
prng.bytes 5             #=> "\xA4.~\xAC\xAB"
