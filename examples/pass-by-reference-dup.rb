def llama_sans_l(llama)
  llama.dup.gsub!(/l/i,'')
end
llama = 'Larry'
llama_sans_l(llama) #=> 'arry'
llama #=> 'Larry'
