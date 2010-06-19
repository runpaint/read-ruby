source, dest = "a\ubeefbc", ""
ec = Encoding::Converter.new('utf-8', 'ascii')
until source.empty?
  if ec.primitive_convert(source, dest) == :undefined_conversion
    ec.insert_output("<U+%.4X>" % ec.last_error.error_char.ord)
  end
  p [source, dest, *ec.primitive_errinfo]
end
#=> ["bc", "a", :undefined_conversion, "UTF-8", "US-ASCII", "\xEB\xBB\xAF", ""]
#=> ["", "a<U+BEEF>bc", :finished, nil, nil, nil, nil]
