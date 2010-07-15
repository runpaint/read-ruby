"foresight".sub(/(?!s)ight/, 'ee')           #=> "foresee"
"anterior".sub(/(?<!eleph)an(?=t)/, 'pos')   #=> "posterior"
%w{An abbess abjures an oblate 
   for his absurd abacus}.grep /\A.b(?![four]).{4}(?!i?e)\z/ 
#=> ["abbess", "oblate", "absurd", "abacus"]
