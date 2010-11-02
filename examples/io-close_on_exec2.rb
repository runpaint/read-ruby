open('/tmp/f','w'){|f| f << 'sekrit'}
f = open('/tmp/f')
f.close_on_exec = true
f.close_on_exec? #=> true
exec("ruby -e 'p IO.open(#{f.fileno}).read'")
# Prints:
#-e:1:in `initialize': Bad file descriptor (Errno::EBADF)
#	from -e:1:in `open'
#	from -e:1:in `<main>'
