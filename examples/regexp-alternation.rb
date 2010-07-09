%w{cat ls catls cats ca}.grep /\A(cat|ls)\Z/
#=> ["cat", "ls"]
(%w{cat ls(1) echo(1) cats} << '').grep /\A((cat|ls)\(\d+\)|echo|)\Z/
#=> ["ls(1)", ""]
%w{xx xy yX yy yz zz xixi xz}.grep /\A(x(?i:x|y)|y(?i:x|y)|z)\Z/ 
#=> ["xx", "xy", "yX", "yy"]
