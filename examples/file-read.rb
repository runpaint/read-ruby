File.read('/etc/timezone') #=> "Europe/London\n"
File.read('/etc/timezone', 6) #=> "Europe"
File.read('/etc/timezone', 6, 7) #=> "London"
