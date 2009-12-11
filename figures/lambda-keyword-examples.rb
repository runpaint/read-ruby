def intermittently wait, closure
  loop { sleep(wait.call) and rv = closure[Time.now] and return rv }
end
require 'prime'
prime_time = lambda do |t| 
  t.strftime("%T:%6N") if [t.hour, t.min, t.sec, t.usec].all?(&:prime?)
end
intermittently lambda { Random.new.rand(3.0) }, prime_time #=> "11:29:47:435997"
