# Value of KDSETLED; see `man 2 ioctl_list` or `grep` /usr/include for
# the corresponding value on your system
KDSETLED = 0x4B32
def flash n
  @tty ||= open("/dev/console") # You'll probably need to be root
  @tty.ioctl(KDSETLED, n)
  sleep 0.1
end

at_exit { flash 0 }

loop do
  (0..6).each do |n| 
    [n, ~n, n].each{|m| flash m }
  end
end
