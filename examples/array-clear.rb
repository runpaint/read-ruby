banned = ['Animal Farm', 'Areopagitica', 
          'Brave New World', 'Fanny Hill']
banned.taint
banned.untrust
banned.clear      #=> []
banned.size       #=> 0
banned.tainted?   #=> true
banned.untrusted? #=> true
