h = {a: 1, b: 2}
h[:c] #=> nil
h.default #=> nil
h = Hash.new(0)
h[:c] #=> 0
h[:c] = 3
h[:c] #=> 3
h.default = ??
h[:d] #=> "?"
require 'prime'
next_prime = Hash.new do |h, k|
  prime = k.succ
  prime += 1 until prime.prime?
  h[k] = prime
end
[12, 17, 48, 200].map{|n| next_prime[n]} #=> [13, 19, 53, 211]
next_prime #=> {12=>13, 17=>19, 48=>53, 200=>211}
