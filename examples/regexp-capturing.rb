time = /\A(?<hours>(0\d|1[0-9]|2[0-3])):(?<minutes>([1-5]\d|0\d))\Z/
match = time.match '11:30'
match[:hours] #=> "11"
match[:minutes] #=> "30"
