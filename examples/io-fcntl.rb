require 'fcntl'
$stdout.fcntl(Fcntl::F_DUPFD) #=> 3
f = open('/tmp/file', ?w)
f.fcntl(Fcntl::F_SETFD, Fcntl::FD_CLOEXEC)
f.close_on_exec? #=> true
access_mode = f.fcntl(Fcntl::F_GETFL) & Fcntl::O_ACCMODE
access_mode == Fcntl::O_WRONLY #=> true
f.fcntl(Fcntl::F_SETFL, access_mode | Fcntl::O_APPEND)
f.fcntl(Fcntl::F_GETFL) & Fcntl::O_APPEND == Fcntl::O_APPEND #=> true
