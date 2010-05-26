require 'tempfile'
class Class
  def children
    ObjectSpace.each_object(Class).select{|c| c < self}
  end
end
Delegator.children #=> [SimpleDelegator, Tempfile, #<Class:0x8a2edbc>]
