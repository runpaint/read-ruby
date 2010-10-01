digits = (0..9).to_a
digits.delete_if{|d| d > 7}
#=> [0, 1, 2, 3, 4, 5, 6, 7]
digits.keep_if(&:odd?)
#=> [1, 3, 5, 7]
digits.select!{|d| d**2 > d}
#=> [3, 5, 7]
digits.reject!(&:even?)
#=> nil
