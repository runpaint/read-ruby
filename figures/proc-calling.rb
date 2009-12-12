person = ->(age) do
  "#{age}: (" + case age
    when (0..12)  then 'child'
    when (13..19) then 'teenager'
    when (20..59) then 'adult'
    else               'pensioner'
  end + ")"
end
person.call(19) #=> "19: (teenager)"
person.(101)    #=> "101: (pensioner)"
person.yield 8  #=> "8: (child)"
person[10]      #=> "10: (child)"
person === 26   #=> "26: (adult)"
