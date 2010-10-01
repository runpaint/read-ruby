dna = [?A, ?C, ?G, ?T]
dna.combination(2).to_a
#=> [["A", "C"], ["A", "G"], ["A", "T"], 
#    ["C", "G"], ["C", "T"], ["G", "T"]]
dna.repeated_combination(2).to_a
#=> [["A", "A"], ["A", "C"], ["A", "G"], ["A", "T"], ["C", "C"], 
#    ["C", "G"], ["C", "T"], ["G", "G"], ["G", "T"], ["T", "T"]]
