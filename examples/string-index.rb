alphabet = [*?a..?z].join
alphabet.index ?e #=> 4
alphabet.index /[aeiou]/ #=> 0
alphabet.index '~' #=> nil
alphabet.index(/[[:xdigit:]]/) #=> 0
alphabet.rindex(/[[:xdigit:]]/) #=> 5
alphabet << alphabet
alphabet.index ?e, 10 #=> 30
