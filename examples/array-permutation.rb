dna = [?A, ?C, ?G, ?T]
dna.permutation(2).to_a
#=> [["A", "C"], ["A", "G"], ["A", "T"], ["C", "A"], ["C", "G"], 
#    ["C", "T"], ["G", "A"], ["G", "C"], ["G", "T"], ["T", "A"], 
#    ["T", "C"], ["T", "G"]]
dna.repeated_permutation(2).select{|a,b| a == b} 
#=> [["A", "A"], ["C", "C"], ["G", "G"], ["T", "T"]]
