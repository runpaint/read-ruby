# coding: utf-8
utf8 = /caf(e|é)/
utf8.encoding          #=> #<Encoding:UTF-8>
iso88591_a = Regexp.new('caf(e|é)'.encode('iso-8859-1'))
iso88591_b = Regexp.new(utf8.source.encode('iso-8859-1'))
iso88591_a == iso88591_b #=> true
iso88591_a.encoding      #=> #<Encoding:ISO-8859-1>
