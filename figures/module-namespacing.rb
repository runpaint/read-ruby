module CPU
  def self.processors
    File.read('/proc/cpuinfo').split(/\n\n/).map{|processor| Hash[
        processor.lines.reject{|line| line.end_with?(':')}.
                        map{|line| line.chomp.split(/\t+:\s?/)}
    ]}
  end
end

cpu = CPU.processors.first
cpu['model name'] + ' with a ' + cpu['cache size'] + ' cache'
#=> "Intel(R) Atom(TM) CPU N270   @ 1.60GHz with a 512 KB cache"
