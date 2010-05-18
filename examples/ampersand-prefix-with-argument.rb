title = ->(name) { %w{Mr Mrs Sir Dr}.sample + ' ' + name }
title.is_a?(Proc) #=> true
['Stephen Hawking', 'R. Feynman', 'Niels Bohr'].map(&title)
#=> ["Dr Stephen Hawking", "Mrs R. Feynman", "Sir Niels Bohr"]
