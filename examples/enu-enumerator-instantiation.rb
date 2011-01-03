"Once bitten, twice shy".to_enum(:bytes).first(5)
#=> [79, 110, 99, 101, 32]
Enumerator.new do |yielder|
  (1..Float::INFINITY).each do |n|
    yielder << n if n.odd?
  end
end.first(5) #=> [1, 3, 5, 7, 9]
