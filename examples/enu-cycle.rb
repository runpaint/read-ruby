[].cycle{ raise } #=> nil
[:a, :b, :c].cycle(2).to_a #=> [:a, :b, :c, :a, :b, :c]
(1..100).cycle(100).with_index do |n,i| 
  break [n,i] if (n * i).to_s(16) =~ /^([[:xdigit:]]{2})\1$/
end #=> [58, 257]
