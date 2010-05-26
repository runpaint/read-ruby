class Parent
  @@cvar = :parent
  def self.cvar
    @@cvar
  end
end
Child = Class.new Parent
Parent.cvar #=> :parent
Child.cvar  #=> :parent
