Dir.chdir('/etc') do
  File.realpath '/etc/resolv.conf' #=> "/etc/resolv.conf"
  File.realpath 'resolv.conf' #=> "/etc/resolv.conf"
  File.readlink '/etc/alternatives/www-browser' #=> "/usr/bin/w3m"
  File.realpath '../etc/alternatives/../alternatives/ruby'
  # No such file or directory - /etc/alternatives/ruby (Errno::ENOENT)
  File.realdirpath '../etc/alternatives/../alternatives/ruby' #=> "/etc/alternatives/ruby"
end

