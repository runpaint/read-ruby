# String#capitalize returns the capitalized receiver without mutating it.
dungeon = 'oubliette'
dungeon.capitalize #=> "Oubliette"
dungeon #=> "oubliette"

# String#capitalize! capitalizes the receiver in place.
dungeon.capitalize! #=> "Oubliette"
dungeon #=> "Oubliette"
