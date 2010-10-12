{lemon: :yellow, orange: :orange, apple: [:red, :green]}
#=> {:lemon=>:yellow, :orange=>:orange, :apple=>[:red, :green]}
{?a => :vowel,     ?b => :consonant, ?c => :consonant,
 ?d => :consonant, ?e => :vowel,     ?f => :consonant}
#=> {"a"=>:vowel, "b"=>:consonant, "c"=>:consonant, 
     "d"=>:consonant, "e"=>:vowel, "f"=>:consonant}
{:london => :england, :londonderry => :ireland, london: :ontario}
#=> {:london=>:ontario, :londonderry=>:ireland}
