(:aa..:zz).find_index(:az) #=> 25
stages = {baby: :infant, infant: :toddler, toddler: :preteen, teen: :adult}
stages.find_index{|from, to| from == :toddler} #=> 2
stages.find_index{|from, to| from == :adult} #=> nil
