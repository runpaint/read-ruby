@@cvar = :top
class Top
  def self.cvar
    @@cvar
  end
end
Top.cvar #=> :top
class Top
  @@cvar = :class
end
Top.cvar #=> :class
@@cvar   #=> :class
