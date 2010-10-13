digits = 0..9
digits.all?{|d| d < 10} #=> true
digits.none?{|d| (d ** 2) > 10} #=> false
digits.one?{|d| d == 3} #=> true
digits.any?{|d| d == 3} #=> true
(1...Float::INFINITY).any?{|d| d % 10 == 2} #=> true
[5, Rational(8, 2), ''[1], :nil].all? #=> false
users = IO.foreach('/etc/passwd').map{|user| user.split(/:/)}
users.all?{|u| u.last.start_with?(?/)} and users.one?{|u| u.first == 'root'} #=> true
