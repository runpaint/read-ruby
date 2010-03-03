class Llama
  def name(name='Larry')
    name + ' the llama (beast of burden)'
  end
end
Llama.new.name
#=> "Larry the llama (beast of burden)"
Llama.new.name('Lyle Jr.')
#=> "Lyle Jr. the llama (beast of burden)"
Llama.new.name('Lama', 'glama')
#=> ArgumentError: wrong number of arguments (2 for 1)
