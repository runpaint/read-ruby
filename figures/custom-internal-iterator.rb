def intermittently(array)
  array.each do |element|
    sleep rand(10) * (element.size % array.size)
    yield element
  end
end

intermittently([191, 2726, 278, 12**10, 182729]) do |element|
  puts Time.now.strftime("%H:%M:%S") + " => #{element}"
end
# 00:29:33 => 191
# 00:29:33 => 2726
# 00:29:45 => 278
# 00:30:06 => 61917364224
# 00:30:34 => 182729
