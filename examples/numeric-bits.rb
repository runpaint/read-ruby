def next_power_of_2 n
  [1,2,4,8,16].inject(n - 1){|memo, x| memo |= memo >> x}.succ
end
[34, 67, 82720, 1024].map{|n| next_power_of_2 n} #=> [64, 128, 131072, 1024]

mask       =->(pos)          { 1 << pos }
set_bit    =->(f, pos)       { f | mask[pos]}
clear_bit  =->(f, pos)       { f & ~(mask[pos])}
modify_bit =->(f, pos, state){ f & ~mask[pos] | (-state & mask[pos])}
f = 0b1110001
f = set_bit[f, 3]; f.to_s(2)       #=> "1111001"
f = clear_bit[f, 5]; f.to_s(2)     #=> "1011001"
f = modify_bit[f, 0, 0]; f.to_s(2) #=> "1011000"
