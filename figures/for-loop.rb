string = ''
for element in 97..100
  string << element if element.odd?
end
string #=> "ac"
