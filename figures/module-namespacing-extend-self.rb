module CPU
  extend self
  def processors
    File.read('/proc/cpuinfo').split(/\n\n/).map{|processor| Hash[
        processor.lines.reject{|line| line.end_with?(':')}.
                        map{|line| normalise *line.chomp.split(/\t+:\s?/)}
    ]}
  end

  private
  def normalise(key, value)
    key = key.gsub(/\s/,'_').to_sym
    return [key, value.split.map(&:to_sym)] if key == :flags
    [key] << case value
      when /^\d+$/      then value.to_i
      when /^\d+\.\d+$/ then value.to_f
      when 'no'         then false
      when 'yes'        then true
      else              value
    end
  end
end

cpu = CPU.processors.first
cpu[:model_name] + ' has the :mmx flag set' if cpu[:flags].include?(:mmx)
#=> "Intel(R) Atom(TM) CPU N270   @ 1.60GHz has the :mmx flag set"
"It doesn't have any known bugs" if cpu.keys.grep(/_bug/).map{|bug| cpu[bug]}.none?
#=> "It doesn't have any known bugs"
"Its faster than 500MHz" if cpu[:cpu_MHz] > 500
#=> "Its faster than 500MHz"
