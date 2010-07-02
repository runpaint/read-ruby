"3^3 = 27".scan(/\d/) #=> ["3", "3", "2", "7"]
cube = 'faces: 6; volume: a^3; area: 6a^2'.scan(/(\w+): ([^;]+)/).map do |k, v|
  [k.to_sym, v]
end
Hash[cube] #=> {:faces=>"6", :volume=>"a^3", :area=>"6a^2"}
'Cubes: 1^3 = 1, 2^3=8, 3^3 = 27  4^3 = ?, 5^3 = 125, 6^3 = 215'.
  scan(/(?<base>\d+)\^3\s*=\s*(?:(?<an>\d+)|(?<un>\?))/) do |base, answer|
    cube = base.to_i ** 3  
    puts "%d^3 == %d" %  [base, cube] unless cube == answer.to_i
  end
# 4^3 == 64
# 6^3 == 216
