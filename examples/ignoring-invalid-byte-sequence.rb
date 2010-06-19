source, dest = "a\u6543bc", ""
source.setbyte(2,0)
ec = Encoding::Converter.new('utf-8', 'ascii')
until source.empty?
  ec.primitive_convert(source, dest)
  p [source, dest, *ec.primitive_errinfo]
end
#=> ["\x83bc", "a", :invalid_byte_sequence, "UTF-8", "US-ASCII", "\xE6", "\x00"]
#=> ["bc", "a\x00", :invalid_byte_sequence, "UTF-8", "US-ASCII", "\x83", ""]
#=> ["", "a\x00bc", :finished, nil, nil, nil, nil]
