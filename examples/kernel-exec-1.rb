exec("no-such-command")
#=> Errno::ENOENT
exec("ls /usr/share/dict/* | wc")
#     5       5     172
