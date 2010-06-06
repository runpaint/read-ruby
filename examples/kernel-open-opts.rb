# coding: utf-8
open('/tmp/file', mode: ?w) {|f| f.print "text\r\n"}
text = File.read('/tmp/file') #=> "text\r\n"
text.encoding == Encoding::UTF_8
open('/tmp/file', mode: ?a){|f| f << "more text"}
open('/tmp/file', textmode: true, external_encoding: 'ascii') do |f| 
  text = f.read #=> "text\nmore text"
  text.encoding #=> Encoding::US_ASCII
end
