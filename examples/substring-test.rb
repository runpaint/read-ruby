uname = `uname -a`
#=> "Linux paint 2.6.32-23-generic #37-Ubuntu SMP Fri Jun 11 07:54:58 UTC 2010
# i686 GNU/Linux\n"
uname.start_with?('Linux') #=> true
uname.chomp.end_with?('Linux') #=> true
uname.include?('ubuntu') #=> false
uname.include?(2010.to_s) #=> true
uname.include?(?#) #=> true
