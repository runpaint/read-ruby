snomed = {T: :Topography, M: :Morphology, L: :Living_organisms, C: :Chemical,
          F: :Fever, J: :Occupation, D: :Diagnosis, P: :Procedure, 
          A: :Physical,  S: :Social_context, G: :General}
snomed.value? :Diagnosis #=> true
snomed.value? :Imaginary #=> false
snomed.values #=> [:Topography, :Morphology, :Living_organisms, :Chemical, :Fever, :Occupation, 
#=> :Diagnosis, :Procedure, :Physical, :Social_context, :General]
snomed.each_value.reject{|v| v =~ /^#{snomed.key(v)}/} #=> [:Occupation, :Physical]
