r, w = IO.pipe
w << 'secret'
w << ' message'
w.close_write
r.read #=> "secret message"
