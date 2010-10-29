o = Object.new
$y = []
def o.each
  3.times.map{|n| yield n}
end
e = o.to_enum
e.next   #=> 0
e.feed 0 #=> nil
e.next   #=> 1
e.next   #=> 2
(e.next rescue $!).result #=> [0. nil, nil]
