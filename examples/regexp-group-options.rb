%w{CASE case CAse caSE cASe casE}.grep /(?i:ca)se/
#=> ["case", "CAse"]
%W{fin\n fi\n\n \n\n fin\r\n find}.grep /f.{2}(?m:.)\Z/
#=> ["fin\n", "fin\r\n", "find"]
/space(?x: m
           a
           n # or 'woman'...
      ) #\d+/ =~ 'spaceman #47'
#=> 0
/x(?xi:
 i)/ =~ 'xI' #=> 0
