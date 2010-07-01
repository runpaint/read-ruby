# coding: utf-8
str = "\"a\b\u{63}\t\x12\u{200}\""
str.inspect #=> "\"a\bc\t\u0012Ȁ\""
str.dump    #=> "\"a\bc\t\x12\u{200}\""
