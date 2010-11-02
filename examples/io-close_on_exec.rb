open('/tmp/f','w'){|f| f << 'sekrit'}
f = open('/tmp/f')
f.close_on_exec? #=> false
exec("ruby -e 'p IO.open(#{f.fileno}).read'")
# Prints "sekrit"
