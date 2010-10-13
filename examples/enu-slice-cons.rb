plants = [:Hornworts, :Mosses, :Liverworts, :Conifers, :Cycads, :flowering_plants]
plants.each_slice(1).to_a
#=> [[:Hornworts], [:Mosses], [:Liverworts], [:Conifers], [:Cycads], [:flowering_plants]]
plants.each_cons(1).to_a
#=> [[:Hornworts], [:Mosses], [:Liverworts], [:Conifers], [:Cycads], [:flowering_plants]]
plants.each_slice(2).to_a
#=> [[:Hornworts, :Mosses], [:Liverworts, :Conifers], [:Cycads, :flowering_plants]]
plants.each_cons(2).to_a
#=> [[:Hornworts, :Mosses], [:Mosses, :Liverworts],      [:Liverworts, :Conifers], 
#=>  [:Conifers, :Cycads],  [:Cycads, :flowering_plants]]
plants.each_slice(4).to_a.flatten.count(:Liverworts) #=> 1
plants.each_cons(4).to_a.flatten.count(:Liverworts) #=> 3
plants.each_slice(5).count #=> 2
plants.each_cons(5).count #=> 2
