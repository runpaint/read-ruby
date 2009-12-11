require 'resolv'
->(host) do 
  Resolv.getaddress host
end.call 'runpaint.org' #=> "208.94.116.80"
resolv = ->(ips) { Hash[ ips.map {|n| [n, Resolv.getname(n)]} ] }
resolv[%w{128.9.160.27 66.80.146.7 65.181.149.201 217.147.82.116}] 
#=> {"128.9.160.27"  =>"www.rfc-editor.org", "66.80.146.7"   =>"forced.attrition.org",
#=>  "65.181.149.201"=>"ycombinator.com",    "217.147.82.116"=>"ns.irational.org"}
resolv.('128.30.52.45', '69.13.187.182')
#=> in `call': wrong number of arguments (2 for 1) (ArgumentError)
