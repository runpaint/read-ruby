class Schneier
  private
  def blowfish
    "Teach a man to fish..."
  end
end
Schneier.new.blowfish #=> NoMethodError

class Schneier
  def backdoor
    self.blowfish
  end
end
Schneier.new.backdoor #=> NoMethodError

class Schneier
  def backdoor
    blowfish
  end
end
Schneier.new.backdoor #=> "Teach a man to fish..."
