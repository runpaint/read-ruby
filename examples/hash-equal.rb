{} == {} #=> true
{foo: :bar, "foo" => :bar} == {foo: :bar, "foo" => :bar} #=> true
{a: 1, b: 2} == {b: 2, a: 1} #=> true
{a: 1, b: 2} == {a: 1} #=> false
Hash.new(8) == {} #=> true
{key: :value} == [:key, :value] #=> false
a = {a: 1}
a[:b] = a
a == a.merge(b: a) #=> true
