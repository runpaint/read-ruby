# coding: utf-8
class P
  def self.convoluted?
    true
  end
end
C = Class.new(P)
C.superclass == P                                 #=> true
C.singleton_class.superclass == P.singleton_class #=> true
C.convoluted?                                     #=> true
