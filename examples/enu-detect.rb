(?b..?r).detect{|e| e =~ /[aeiou]/} #=> "e"
(?b..?r).detect{|e| e =~ /[[:upper:]]/} #=> nil
[Rational(1,10), Rational(7,10), Rational(4,10)].find(->{ 10 }){|e| e > 10} #=> 10
