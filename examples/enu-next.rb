e = (1..3).to_enum
loop { print e.next } # 123
e.rewind
[e.next, e.next, e.next] #=> [1, 2, 3]
e.next #=> StopIteration
