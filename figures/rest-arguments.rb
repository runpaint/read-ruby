def zero_or_more(*rest)
  rest.join(', ')
end
zero_or_more #=> ""
zero_or_more(1) #=> "1"
zero_or_more(1,2,3) #=> "1, 2, 3"
