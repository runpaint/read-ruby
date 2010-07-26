str = 'indolent poltroon!'
str.match /ro?/                 #=> #<MatchData "ro">
str.match /ro??/                #=> #<MatchData "r">
str.match /n*t/                 #=> #<MatchData "nt">
str.match /n*?t/                #=> #<MatchData "nt">
str.match /i.+t/                #=> #<MatchData "indolent polt">
str.gsub(/i.+?t/, 'gluttonous') #=> "gluttonous poltroon!"
