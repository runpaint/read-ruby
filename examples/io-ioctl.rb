# Value of KDSETLED; see `man 2 ioctl_list` or `grep` /usr/include for
# the corresponding value on your system
KDSETLED = 0x00004B32
def flash n
  @tty ||= open("/dev/console") # You'll probably need to be root
  @tty.ioctl(KDSETLED, n)
  sleep 0.1
end

trap('INT') do
  flash 0
  exit
end

loop do
  (0..6).each do |n|
    flash 0 | n
    flash 0 & ~n
    flash 0  ^ n
  end
end
