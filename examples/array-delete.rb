italians = %w{Abbati   Albertinelli Allori     Allori Altichiero 
              Amigoni  Angelico     Anguissola Arcimboldo}
italians.delete('Allori') #=> "Allori"
italians.delete('Abbati') #=> "Abbati"
italians.delete('Allori') #=> nil
italians.delete('Azzolini') do |name| 
  "#{name}: ???"
end                       #=> "Azzolini: ???"
italians
#=> ["Albertinelli", "Altichiero", "Amigoni", 
#    "Angelico", "Anguissola", "Arcimboldo"]
