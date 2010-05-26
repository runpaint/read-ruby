module Letter
  def letter
    l = ('A'..'Z').reject{|l| Object.const_defined?(l)}.first
    mod = Module.new do
      include Letter
      define_method(:letter, ->{ super(); l })
    end
    self.class.module_eval{ include Object.const_set(l, mod) }
    '->'
  end
end
class Alphabet
  include Letter
  def letter(n)
    n.times.map{super()}.join 
  end
end
Alphabet.new.letter(6) #=> "->ABCDE"
Alphabet.ancestors
#=> [Alphabet, F, E, D, C, B, A, Letter, Object, Kernel, BasicObject]
