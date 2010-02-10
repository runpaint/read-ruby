def look_and_say(seed=1, max_terms)
  [seed].tap do |terms|
    until terms.size >= max_terms or terms.last == terms[-2]
      last = terms.last.to_s.split(//)
      term = [[1,last.first]]
      last[1..-1].each do |e|
        term.last.last == e ? term.last[0] += 1 : term << [1, e]
      end
      terms << term.join.to_i
    end
  end
end
look_and_say(7) #=> [1, 11, 21, 1211, 111221, 312211, 13112221]
