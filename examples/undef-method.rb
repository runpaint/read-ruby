def boo!
  "(goose)"
end
boo! #=> "(goose)"              
undef :boo!
boo! #=> NoMethodError: undefined method `boo!' for main:Object 
