# Does a String contain a digit?
/\d/ =~ 'two: 2' #=> 5
# (Yes, starting at this fifth character)
/\d/ =~ 'Nope' #=> nil
# (No)

# Which Strings in an Array contain 'cat' case-insensitively?
%w{dogma verification wildcat dogfish medicate underdog Catholicism}.grep /cat/i
#=> ["verification", "wildcat", "medicate", "Catholicism"]
