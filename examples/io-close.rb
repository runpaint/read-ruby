$stdin.closed? #=> false
$stdin.close #=> nil
$stdin.gets #=> IOError
pipe = IO.popen(ENV['SHELL'],'r+')
pipe.close_write #=> nil
pipe.closed? #=> false
pipe.close_read #=> nil
pipe.closed? #=> true
