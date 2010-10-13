(?a..?f).map &:upcase
#=> ["A", "B", "C", "D", "E", "F"]
(10..20).map{|n| n**2 }
#=> [100, 121, 144, 169, 196, 225, 256, 289, 324, 361, 400]
{ 'google.com' => 'Google',
  'ruby-lang.org' => 'Ruby',
  'wikipedia.org' => 'Wikipedia'}.map do |host, anchor|
  "<a href=//#{host}/>#{anchor}</a>"
end 
#=> ["<a href=//google.com/>Google</a>", "<a href=//ruby-lang.org/>Ruby</a>", 
#=>  "<a href=//wikipedia.org/>Wikipedia</a>"]
[10..20, 20..30, 30..40, 40..50].collect{|r| r.to_a.sample}
#=> [16, 30, 36, 44]
shells = IO.foreach('/etc/passwd').flat_map{|l| l.chomp.split(/:/).values_at(0,-1)}
Hash[*shells]['kernoops'] #=> "/bin/false"
