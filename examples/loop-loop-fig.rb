class Integer
  def happy?
    return false unless self > 0
    sad, sequence = [4, 16, 37, 58, 89, 145, 42, 20], [self]
    loop do
      sequence << sequence.last.to_s.split(//).map{|d| d.to_i ** 2}.reduce(:+)
      return true if sequence.last == 1
      return false if sequence.last(sad.size) == sad
    end
  end
end
(1..15).select(&:happy?) #=> [1, 7, 10, 13]
