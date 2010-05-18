class Context
  @@where = :class
  def self.context
    binding
  end
end
eval "@@where", Context.context #=> :class
