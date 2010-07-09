%w{0bB0 0b1111010 0b(0|1)+ 0B1}.grep /\A0[bB](0|1)+\Z/
#=> ["0b1111010", "0B1"]
%w{+Infinity -Infinity Infinity NaN -NaN}.grep /\A(([+-]?Infinity)|NaN)\Z/
#=> ["+Infinity", "-Infinity", "Infinity", "NaN"]
%w{0x 0xfeed food 0xae!}.grep /\A0x[[:xdigit:]]*\Z/
#=> ["0x", "0xfeed"]
%w{0 01 08 o 065 0123 051171 082 0o0}.grep /\A0[0-7]{2,4}\Z/
#=> ["065", "0123"]
%w{NaN+ a4 00.0 3. 2\n.7 07 42 -Infinity +34.21 -0.54 1.23232 Infinity.2}.grep \
  /\A(NaN| # The string 'NaN', OR
      [-+]?( # An optional sign, then
        
        Infinity| # The string 'Infinity', OR

        ([1-9]\d+|\d) # A non-zero digit followed by one or more digits, OR 
                      # a single digit by itself, then
          (\.\d{1,4})?  # optionally, a literal '.' followed by 1-4 digits 
      )
     )\Z/x #=> ["42", "-Infinity", "+34.21", "-0.54"]
