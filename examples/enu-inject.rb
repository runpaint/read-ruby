%w{a b c d}.reduce(:+) #=> "abcd"
(2..8).reverse_each.inject(:-) #=> -19
[[:a, 4], [:b, 12], [:c, 9]].reduce(1){|acc, el| acc * el.last} #=> 432
[{joe: 27}, {bob: 23}, {jim: 40}, {jolene: 18}].reduce :merge
#=> {:joe=>27, :bob=>23, :jim=>40, :jolene=>18}
Dir["#{Dir.home}/.*"].reduce do |newest, file| 
  File.file?(file) && File.mtime(newest) < File.mtime(file) ? file : newest
end #=> "/home/run/.xsession-errors
