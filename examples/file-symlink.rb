link, target = '/tmp/link', '/tmp/target'
File.unlink(link) if File.exist?(link)
open(target, mode: ?w) {}
File.symlink(target, link)
File.symlink?(target) #=> false
File.symlink?(link)   #=> true
File.readlink(link)   #=> "/tmp/target"
