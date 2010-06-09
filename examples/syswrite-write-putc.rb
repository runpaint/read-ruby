str = 'Prefer parchment?'
$stdout.syswrite(str) #=> 17
# Writes "Prefer parchment?" to $stdout
$stdout.write(str) #=> 17
# Writes "Prefer parchment?" to $stdout
$stdout.putc(str) #=> "Prefer parchment?"
# Writes "P" to $stdout
STDERR.putc(str[0].ord) #=> 80
# Writes "P" to STDERR
