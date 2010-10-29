e = [:rinse, :repeat].to_enum
e.next #=> :rinse
e.next #=> :repeat
begin
  e.next
rescue StopIteration => ex
  ex.result #=> [:rinse, :repeat]
end
e.rewind
loop{ p e.next }
# :rinse
# :repeat
