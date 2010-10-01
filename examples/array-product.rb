one_two = [1, 2]
ab = [?a, ?b]
one_two.product(ab, [:_])
#=> [[1, "a", :_], [1, "b", :_], [2, "a", :_], [2, "b", :_]]
