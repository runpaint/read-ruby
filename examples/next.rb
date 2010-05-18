ips = Hash.new {|h,k| h[k] = []}
IO.foreach('/etc/hosts').each do |line|
  next if line.start_with?('#')
  ip, *hosts = line.split
  ips[ip] += hosts
end
ips #=> {"127.0.0.1"=>["localhost"], "127.0.1.1"=>["paint", "read-ruby"],
    #    "::1"=>["localhost"]} #...

