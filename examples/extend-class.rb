module Instances
  def instances
    ObjectSpace.each_object(self).to_a
  end
end
harmonic_sequence = 1.upto(10).map{|d| Rational(1,d)}
def pell(n)
  return n if [0, 1].include?(n)
  2 * pell(n-1) + pell(n-2)
end
approx_sqrt_2 = (1..20).map{|n| Rational(pell(n-1) + pell(n), pell(n))}
Rational.extend(Instances)
Rational.instances.size #=> 30
