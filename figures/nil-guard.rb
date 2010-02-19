# Initially var is nil so 
# it is set to the current time.
var ||= Time.now
var #=> 2010-02-19 10:51:07 +0000

# var is no longer nil, so the following 
# does not change its value
var ||= Time.now
var #=> 2010-02-19 10:51:07 +0000
