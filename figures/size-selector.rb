4.size #=> 4
[:one, :two, :three, :four].size #=> 4
File.open('/tmp/four','w'){ print '1' * 4}
File.new('/tmp/four').size #=> 4
'five'.size #=> 4
