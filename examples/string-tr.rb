str = 'stuffed shirt'
str.tr('st', 'S')      #=> "SSuffed ShirS"
str.tr('a-z', 'A-Z')   #=> "STUFFED SHIRT"
str.tr_s('a-z', 'A-Z') #=> "STUFED SHIRT"
str.tr('shirt', 'toy') #=> "tyuffed toyyy"
