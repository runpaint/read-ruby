[/a/, :a, ?a].include? /a/ #=> true
[Dir.home, __FILE__].include? 47 #=> false
(?~ * 10).include? ?~ #=> true
1.0.step(2.0, 0.1).member? 1.6 #=> true
[[0,1]].include? 0 #=> false
{a:1}.include? :a #=> true
{a:1}.include? 1  #=> false
