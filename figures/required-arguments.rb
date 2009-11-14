class Llama
  def laugh(how, volume)
    puts volume == :loudly ? how.upcase : how
  end
end
Llama.new.laugh #=> ArgumentError: wrong number of arguments (0 for 2)
Llama.new.laugh(:snicker) #=> ArgumentError: wrong number of arguments (1 for 2)
Llama.new.laugh(:chortle,:softly) #=> chortle
Llama.new.laugh(:guffaw,:loudly) #=> GUFFAW
Llama.new.laugh(:ho, :ho, :ho) #=> ArgumentError: wrong number of arguments (3 for 2)
