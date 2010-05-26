def one(argument)
  "One argument: #{argument}"
end

def three(first, second, third)
  "Three arguments: #{first}, #{second}, #{third}"
end

array = [1, 2, 3]
one(array) #=> "One argument: [1, 2, 3]"
three(array) #=> ArgumentError: wrong number of arguments (1 for 3)
three(*array) #=> "Three arguments: 1, 2, 3"
three(1, 2, 3) #=> "Three arguments: 1, 2, 3"
