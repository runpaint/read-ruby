# coding: utf-8
str = "Hit him on the head\n" +
      "Hit him on the head with a 2×4\n"
str.scan(/^Hit/)     #=> ["Hit", "Hit"]
str.scan(/\AHit/)    #=> ["Hit"]
str =~/head$/        #=> 15
str.scan(/\d\Z/)     #=> ["4"]
str =~ /\d\z/        #=> nil
str.scan(/\b\d/)     #=> ["2", "4"]
str.scan(/\w+\B/)
#=> ["Hi", "hi", "o", "th", "hea", "Hi", "hi", "o", "th", "hea", "wit"]
