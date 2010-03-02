string = '3 free frogs'
unless string =~ /^\d\./
  $stderr.puts "<#{string}>: must start with a digit followed by a period"
end
# <3 free frogs>: must start with a digit followed by a period
