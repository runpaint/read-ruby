drops = [165, 168, 173, 180]
weight = 14.0
drops.each do |cm|
  puts "Use a #{cm} cm rope for a man of #{weight} stone"
  weight -= 0.5
end
# Use a 165 cm rope for a man of 14.0 stone
# Use a 168 cm rope for a man of 13.5 stone
# Use a 173 cm rope for a man of 13.0 stone
# Use a 180 cm rope for a man of 12.5 stone
drops.each_with_index.to_a
#=> [[165, 0], [168, 1], [173, 2], [180, 3]]
