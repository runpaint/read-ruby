class Integer  
  require 'prime'
  def next_prime
    n = succ
    n += 1 until n.prime?
    n
  end
end
1.upto(10).map {|n| {n => n.next_prime}}
#=> [{1=>2}, {2=>3},  {3=>5},  {4=>5},  {5=>7}, 
#    {6=>7}, {7=>11}, {8=>11}, {9=>11}, {10=>11}]
