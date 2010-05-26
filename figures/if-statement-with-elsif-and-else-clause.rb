# coding: utf-8
class Integer
  require 'prime'

  def square_free?
    prime_division.map(&:last).all?{|p| p == 1}
  end
  
  def möbius
    return if self < 1 # Postfix if statement
    if    not square_free? then                            0
    elsif prime_division.map(&:first).uniq.size.odd? then -1
    else                                                   1
    end
  end
end
(1..10).map(&:möbius) #=> [1, -1, -1, 0, -1, 1, -1, 0, 0, 1]
