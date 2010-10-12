rat = {Rational(1,2) => 0.5, Rational(3,4) => 0.75}
rat[Rational(3,4)] = '3/4'
rat #=> {(1/2)=>0.5, (3/4)=>"3/4"}
rat.compare_by_identity[Rational(1,2)] = '1/2'
rat #=> {(1/2)=>0.5, (3/4)=>"3/4", (1/2)=>"1/2"}
rat.compare_by_identity? #=> true
feet = {cat: :paws, pigs: :hooves, bird: :claws}.compare_by_identity
feet[:pigs] = :cloven_hooves
feet #=> {:cat=>:paws, :pigs=>:cloven_hooves, :bird=>:claws}
