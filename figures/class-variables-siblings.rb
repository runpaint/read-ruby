class Parent
  @@parent = :strict
  def self.parent
    @@parent
  end
end
class Daughter < Parent
  @@parent = :unfair!
  @@me = :angelic
  def self.me; @@me end
end
class Son < Parent
  @@parent = :biased
  @@me = :unappreciated
  def self.me; @@me end
end
# @@parent is shared between Parent, Daughter, and Son, so its current
# value is that which Son assigned it:
Parent.parent   #=> :biased
Daughter.parent #=> :biased
Son.parent      #=> :biased
# @@me is unique among sibling classes (Son and Daughter):
Daughter.me     #=> :angelic
Son.me          #=> :unappreciated
