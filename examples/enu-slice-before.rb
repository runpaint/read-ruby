# -*- coding: utf-8 -*-
 Math::PI.to_s.scan(/\d/).map(&:to_i).slice_before(&:even?).to_a
#=> [[3, 1], [4, 1, 5, 9], [2], [6, 5, 3, 5], [8, 9, 7, 9, 3]]
IO.foreach('/usr/share/dict/words').slice_before(/^[[:upper:]]$/).map{|w| w.last.chomp}[1..5]
#=> ["Aztlan's", "Byzantium's", "Czerny's", "Düsseldorf", "Ezra's"]
(?a..?z).slice_before{|l| %w{a e i o u}.include? l}.to_a
#=> [["a", "b", "c", "d"], ["e", "f", "g", "h"], ["i", "j", "k", "l", "m", "n"], 
#    ["o", "p", "q", "r", "s", "t"], ["u", "v", "w", "x", "y", "z"]]
