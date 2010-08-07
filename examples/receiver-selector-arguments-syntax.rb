cabin_dwellers = []
cabin_dwellers.push(:kaczynski, :roosevelt, :thoreau)
#=> [:kaczynski, :roosevelt, :thoreau]
cabin_dwellers.unshift(cabin_dwellers.pop())
#=> [:thoreau, :kaczynski, :roosevelt]
cabin_dwellers.insert(1, cabin_dwellers.pop)
#=> [:thoreau, :roosevelt, :kaczynski]
