snomed = {T: :Topography, M: :Morphology, L: :Living_organisms, C: :Chemical,
          F: :Fever, J: :Occupation, D: :Diagnosis, P: :Procedure, 
          A: :Physical,  S: :Social_context, G: :General}
snomed.key :General #=> :G
snomed.key? :D #=> true
snomed.include? :E #=> false
snomed.keys #=> [:T, :M, :L, :C, :F, :J, :D, :P, :A, :S, :G]
snomed.each_key.reject{|k| snomed[k] =~ /^#{k}/} #=> [:J, :A]
