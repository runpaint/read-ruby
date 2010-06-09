Dir.chdir('/etc') do
  File.expand_path '/etc/resolv.conf' #=> "/etc/resolv.conf"
  File.expand_path 'resolv.conf' #=> "/etc/resolv.conf"
  File.expand_path '../var/log/messages' #=> "/var/log/messages"
  File.expand_path './filesystems', '/proc' #=> "/proc/filesystems"
  File.expand_path '~/.bashrc' #=> "/home/run/.bashrc"
  ENV['HOME'] = '/tmp' 
  File.expand_path '~/.bashrc' #=> "/tmp/.bashrc"
  File.expand_path '~root' #=> "/root"
end

