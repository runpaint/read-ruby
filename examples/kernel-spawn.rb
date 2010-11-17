pid = spawn('cat /dev/urandom > /dev/null') #=> 24206
`ps --no-headers #{pid}`
#=> "24206 pts/1    S+     0:00 sh -c cat /dev/urandom > /dev/null\n"
system("kill #{pid}") #=> true
