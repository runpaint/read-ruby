`date` #=> "Tue Feb 16 04:01:10 GMT 2010\n"
file = '/etc/fstab'
%x<ls -all #{file}>.chomp
#=> "-rw-r--r-- 1 root root 753 2009-11-19 13:36 /etc/fstab"
