e = (1..3).to_enum
3.times{ print e.next } # 123
e.rewind
[e.peek, e.next, e.peek, e.peek, e.next] #=> [1, 1, 2, 2, 2]
