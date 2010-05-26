class Parent
  def method
    :superclass_instance # 4
  end
end
module M
  def method
    :module_instance     # 3
  end
end
class C < Parent
  include M
  def method
    :class_instance      # 2
  end
end

object = C.new
def object.method
  :object_singleton      # 1
end
