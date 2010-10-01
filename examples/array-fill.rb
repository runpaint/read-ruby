notes = Array.new(7)
notes.fill ?F
#=> ["F", "F", "F", "F", "F", "F", "F"]
notes.fill ?B, 6
#=> ["F", "F", "F", "F", "F", "F", "B"]
notes.fill ?A, 5, 1
#=> ["F", "F", "F", "F", "F", "A", "B"]
notes.fill ?G, 4...5
#=> ["F", "F", "F", "F", "G", "A", "B"]
notes.fill(0..2) do |i|
  case i
    when 0 then ?C
    when 1 then ?D
    when 2 then ?E
  end
end #=> ["C", "D", "E", "F", "G", "A", "B"]
