3.times {|number| print number ** 2, ', ' } #=> 3
# 0, 1, 4,

(:a..:z).select do |letter|
  letter > :r && letter < :y
end #=> [:s, :t, :u, :v, :w, :x]
