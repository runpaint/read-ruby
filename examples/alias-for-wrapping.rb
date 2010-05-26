class String
  alias :old_to_i :to_i
  def to_i
    raise "No digits found" unless match(/\d/)
    old_to_i
  end
end
