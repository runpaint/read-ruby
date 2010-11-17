script = "/tmp/script.rb"
open(script, ?w){|f| f << "#!/usr/local/bin/ruby\np ENV['GLARK']"}
File.chmod 0755, script
exec({'GLARK' => 'always'}, script)
# Prints "always"
