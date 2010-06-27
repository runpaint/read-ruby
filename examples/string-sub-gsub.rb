alphabet = [*?a..?f].join
alphabet.sub(/U/, 'you?') #=> "abcdef"
alphabet.gsub(/[b-e]/){|match| "<U+#{'%.4X' % match.ord}>"}
#=> "a<U+0062><U+0063><U+0064><U+0065>f"
alphabet.sub!(?V, 'for Vendetta') #=> nil
'3 + -4'.sub(/(?<a>\d+) \+ -(?<b>\d+)/, 
             "== \\k<a> - \\k<b>") 
#=> "== 3 - 4"
subs = {?& => '&amp;', ?> => '&gt;'}
subs.default = '?'
'You & I > he & they!'.gsub(/[[:punct:]]/, subs)
#=> "You &amp; I &gt; he &amp; they?"
