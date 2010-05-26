def valid_isbn13?(isbn)
  isbn = isbn.to_s.scan(/\d/).map(&:to_i)
  isbn.size == 13 or return false
  check_digit = 10 - isbn.
                     first(12).
                     map.
                     with_index{|d,i| i.succ.odd? ? d : 3*d}.
                     reduce(:+).
                     modulo(10)
  (check_digit == isbn.last) or (check_digit == 10 and isbn.last.zero?)
end

valid_isbn13?('978-0-596-80948-5') #=> true
valid_isbn13?('9780596809484') #=> false
