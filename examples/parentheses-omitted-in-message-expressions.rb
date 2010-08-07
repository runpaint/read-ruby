"spending".sub(/spend/, 'sav') #=> "saving"
"spending".sub /spend/, 'sav'  #=> "saving"
";".gsub(/(.)/, '.' => 'full stop', ',' => 'comma',
                ';' => 'semicolon') #=> "semicolon"
";".gsub /(.)/, '.' => 'full stop', ',' => 'comma',
                ';' => 'semicolon' #=> "semicolon"
