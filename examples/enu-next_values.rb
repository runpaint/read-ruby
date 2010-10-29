o = Object.new
def o.each
  yield 1
  yield 2, 3
  yield
  yield nil
end
e = o.to_enum
loop.map{ e.next } #=> [1, [2, 3], nil, nil]
e.rewind
loop.map{ e.next_values } #=> [[1], [2, 3], [], [nil]]
e.rewind
2.times.map{ [e.peek_values, e.next] }
#=> [[[1], 1], [[2, 3], [2, 3]]]
