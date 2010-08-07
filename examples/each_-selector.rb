# coding: utf-8
"Böhm-Bawerk".each_line.to_a
#=> ["Böhm-Bawerk"]
"Böhm-Bawerk".each_char.to_a
#=> ["B", "ö", "h", "m", "-", "B", "a", "w", "e", "r", "k"]
"Böhm-Bawerk".each_byte.to_a
#=> [66, 195, 182, 104, 109, 45, 66, 97, 119, 101, 114, 107]
"Böhm-Bawerk".each_codepoint.to_a
#=> [66, 246, 104, 109, 45, 66, 97, 119, 101, 114, 107]
