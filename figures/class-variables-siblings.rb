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
Parent.parent   #=> :biased
Daughter.parent #=> :biased
Son.parent      #=> :biased
Daughter.me     #=> :angelic
Son.me          #=> :unappreciated
