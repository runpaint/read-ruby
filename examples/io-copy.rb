File.open('/tmp/a', ?w){|f| f.puts (?a..?z).to_a.join}
IO.copy_stream(File.open('/tmp/a'), '/tmp/b', 6, 2) #=> 6
File.read('/tmp/b') #=> "cdefgh"
