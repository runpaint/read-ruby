3.times.map{|n| /#{n}/}       #=> [/0/, /1/, /2/]
3.times.map{|n| /#{n}/o}      #=> [/0/, /0/, /0/]
/case/i =~ 'Case'             #=> 0
/Case/i =~ 'cAsE'             #=> 0
/.../m =~ "a\nb"              #=> 0
/f r e e # comment
-spac ing/x =~ 'free-spacing' #=> 0
/EUC-JP/e.encoding            #=> #<Encoding:EUC-JP>
