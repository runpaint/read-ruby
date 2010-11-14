pipes = 5.times.map{ IO.pipe }
readers, writers = pipes.map(&:first), pipes.map(&:last)
Thread.new do
  writers.shuffle!
  while w = writers.pop
    sleep(w.to_i / writers.size) and w << "#{w.to_i}"
    w.close
  end
end.run
until readers.empty? do
  ready = select(readers, writers, [], 1) or abort "Got bored"
  ready.first.each do |box|
    begin
      print "#{box.readline} (wait: #{ready[1].size}) "
    rescue EOFError
      readers.delete(box)
    end
  end
end
# 12 (wait: 4) 10 (wait: 3) 4 (wait: 2) 8 (wait: 1) Got bored
