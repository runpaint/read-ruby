def llama_sans_l(llama)
  llama.gsub!(/l/i,'')
end
llama = 'Larry'
llama_sans_l(llama) #=> 'arry'
llama #=> 'arry'
