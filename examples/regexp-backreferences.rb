/(.)\1/ =~ 'UU' #=> 0
$1 #=> 'U'
%w{emaciate usurious enyzyme fists overdo unkind}.
  grep(/\A(?<vowel>[aeiou])(?<consonant>[^aeiou])\w+\k<vowel>\Z/)
#=> ["emaciate", "enyzyme", "overdo"]
pattern = %r{\A(?<scheme>[a-z]+)://(?<host>[^/]+)(?::\d+)}
match = pattern.match 'http://example.ORG:80/'
#=> #<MatchData "http://example.ORG:80" scheme:"http" host:"example.ORG">
match[:host] #=> "example.ORG"
$1 #= "http"
$~[:scheme] #=> "http"
